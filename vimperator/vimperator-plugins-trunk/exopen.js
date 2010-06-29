var PLUGIN_INFO =
<VimperatorPlugin>
<name>{NAME}</name>
<description>Open URL from a template</description>
<description lang="ja">テンプレートからURLをOpenします</description>
<minVersion>2.0pre</minVersion>
<maxVersion>2.0pre</maxVersion>
<updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/exopen.js</updateURL>
<author homepage="http://vimperator.g.hatena.ne.jp/pekepekesamurai/">pekepekesamurai</author>
<version>0.10.1</version>
<detail lang="ja"><![CDATA[
== Command ==
:exopen [template_name]
  [template_name] で設定されたURLを開きます。

=== Example ===
:exopen http://www.google.co.jp/search?q=%TITLE%:
  %TITLE%を現在開いているWebページのタイトルに展開してURLを開きます。
:exopen [title]
  テンプレートで設定されたURLを開きます。

== Keyword ==
%TITLE%:
  現在のWebページのタイトル
%URL%:
  現在のWebページのURL
%SEL%:
  選択中の文字列
%HTMLSEL%:
  選択中のHTMLソース

== .vimperatorrc ==
>||
javascript <<EOM
liberator.globalVariables.exopen_templates = [
  {
    label: 'vimpnightly',
    value: 'http://download.vimperator.org/vimperator/nightly/',
    description: 'open vimperator nightly xpi page',
    newtab: true
  }, {
    label: 'vimplab',
    value: 'http://vimperator.org/trac/',
    description: 'open vimperator trac page',
    newtab: true
  }, {
    label: 'vimpscript',
    value: 'http://vimperator.org/trac/wiki/Vimperator/Scripts/',
    description: 'open vimperator trac script page',
    newtab: true
  }, {
    label: 'coderepos',
    value: 'http://coderepos.org/share/browser/lang/javascript/vimperator-plugins/trunk/',
    description: 'open coderepos vimperator-plugin page',
    newtab: true
  }, {
    label: 'sldr',
    value: 'http://reader.livedoor.com/subscribe/%URL%'
  }
];
EOM
||<
label:
  テンプレート名。コマンドの引数で指定してください。
value:
  OpenするURL
custom:
  関数か配列で指定してください。
  関数の場合、return された文字列をオープンします。
  配列の場合、value で指定された文字列を置換します。(条件→Array[0]、置換文字列→Array[1])
description:
  補完時に表示する説明文。
newtab:
  新規タブで開く場合は true を指定してください。
escape:
  URLエンコードする場合、true を指定してください。
]]></detail>
</VimperatorPlugin>;

liberator.plugins.exOpen = (function() {
  var global = liberator.globalVariables.exopen_templates;
  if (!global) {
    global = [{
      label: 'vimpnightly',
      value: 'http://download.vimperator.org/vimperator/nightly/',
      description: 'open vimperator nightly xpi page',
      newtab: true
    }, {
      label: 'vimplab',
      value: 'http://vimperator.org/trac/',
      description: 'open vimperator trac page',
      newtab: true
    }, {
      label: 'vimpscript',
      value: 'http://vimperator.org/trac/wiki/Vimperator/Scripts/',
      description: 'open vimperator trac script page',
      newtab: true
    }, {
      label: 'coderepos',
      value: 'http://coderepos.org/share/browser/lang/javascript/vimperator-plugins/trunk/',
      description: 'open coderepos vimperator-plugin page',
      newtab: true
    }, {
      label: 'sldr',
      value: 'http://reader.livedoor.com/subscribe/%URL%'
    }];
  }

  function openTabOrSwitch(url) {
    var tabs = gBrowser.mTabs;
    for (let i=0, l=tabs.length; i<l; i++)
      if (tabs[i].linkedBrowser.contentDocument.location.href == url) return (gBrowser.tabContainer.selectedIndex = i);
    return liberator.open(url, liberator.NEW_TAB);
  }

  function replacer(str, isEscape) {
    if (!str) return '';
    var win = new XPCNativeWrapper(window.content.window);
    var sel = '', htmlsel = '';
    var selection = win.getSelection();
    function __replacer(val) {
      switch (val) {
        case '%TITLE%':
          return buffer.title;
        case '%URL%':
          return buffer.URL;
        case '%SEL%':
          if (sel) return sel;
          else if (selection.rangeCount < 1) return '';
          for (let i=0, c=selection.rangeCount; i<c;
            sel += selection.getRangeAt(i++).toString());
          return sel;
        case '%HTMLSEL%':
          if (htmlsel) return sel;
          if (selection.rangeCount < 1) return '';

          let serializer = new XMLSerializer();
          for (let i=0, c=selection.rangeCount; i<c;
            htmlsel += serializer.serializeToString(selection.getRangeAt(i++).cloneContents()));
          return htmlsel;
      }
      return '';
    }
    var _replacer = __replacer;
    if (isEscape) _replacer = function(val) escape( __replacer(val) );

    return str.replace(/%(TITLE|URL|SEL|HTMLSEL)%/g, _replacer);
  }

  var ExOpen = function() this.initialize.apply(this, arguments);
  ExOpen.prototype = {
    initialize: function() {
      this.createCompleter();
      this.registerCommand();
    },
    createCompleter: function() {
        this.completer = global.map(
          function(t) [t.label, util.escapeString((t.description ? t.description + ' - ' : '') + t.value)]
        );
    },
    registerCommand: function() {
      var self = this;
      commands.addUserCommand(['exopen'], 'Open byextension URL',
        function(args) self.open(args.string, args.bang), {
          completer: function(context, args) {
            context.title = ['Template', 'Description - Value'];
            if (!context.filter) {
              context.completions = self.completer;
              return;
            }
            var filter = context.filter.toLowerCase();
            context.completions = self.completer.filter( function( t ) t[0].toLowerCase().indexOf(filter) == 0 );
          }
      });
    },
    find: function(label) {
      var ret = null;
      global.some(function(template) (template.label == label) && (ret = template));
      return ret;
    },
    open: function(arg) {
      var url = '';
      if (!arg) return;
      var template = this.find(arg) || {value: arg};
      if (typeof template.custom == 'function') {
        url = template.custom.call(this, template.value);
      } else if (template.custom instanceof Array) {
        url = replacer(template.value).replace(template.custom[0], template.custom[1], template.escape);
      } else {
        url = replacer(template.value, template.escape);
      }
      if (!url) return;
      if (template.newtab) openTabOrSwitch(url);
      else liberator.open(url);
    }
  };
  return new ExOpen();
})();
