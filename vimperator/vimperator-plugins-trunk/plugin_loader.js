/* {{{
Copyright (c) 2008, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
# に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
###################################################################################

}}} */

// PLUGIN_INFO {{{
let PLUGIN_INFO =
<VimperatorPlugin>
  <name>Plugin Loader</name>
  <name lang="ja">プラグインローダー</name>
  <description>to load plugins from specified directory at starting up Vimperator.</description>
  <description lang="ja">指定(ディレクトリ|プラグイン)を起動時にロードする</description>
  <version>2.4</version>
  <author mail="anekos@snca.net" homepage="http://d.hatena.ne.jp/nokturnalmortum/">anekos</author>
  <license>new BSD License (Please read the source code comments of this plugin)</license>
  <license lang="ja">修正BSDライセンス (ソースコードのコメントを参照してください)</license>
  <minVersion>2.0pre</minVersion>
  <maxVersion>2.0pre</maxVersion>
  <updateURL>http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/plugin_loader.js</updateURL>
  <detail><![CDATA[
    == Usage ==
      >||
       let g:plugin_loader_roots = "<PLUGIN_DIRECTORIES>"
       let g:plugin_loader_plugins = "<PLUGIN_NAMES>"
      ||<
    == Example ==
      >||
       let g:plugin_loader_roots = "/home/anekos/coderepos/vimp-plugins/ /home/anekos/my-vimp-plugins/"
       let g:plugin_loader_plugins = "lo,migemized_find,nico_related_videos"
      ||<
    == Link ==
       http://d.hatena.ne.jp/nokturnalmortum/20081008#1223397705
  ]]></detail>
</VimperatorPlugin>;
// }}}


{
  function toArray (obj) {
    return obj instanceof Array ? obj
                                : obj.toString().split(/[,| \t\r\n]+/);
  }

  let roots = toArray(liberator.globalVariables.plugin_loader_roots).map(io.expandPath);
  let plugins = toArray(liberator.globalVariables.plugin_loader_plugins);
  let filter = new RegExp('[\\\\/](?:' +
                          plugins.map(function (plugin) plugin.replace(/(?=[\\^$.+*?|(){}\[\]])/g, '\\'))
                                 .join('|') +
                          ')\\.(?:js|vimp)$');

  liberator.log('plugin_loader: loading');

  roots.forEach(function (root) {
    let dir = io.getFile(root);
    if (dir.exists() && dir.isDirectory() && dir.isReadable()) {
      let files = io.readDirectory(dir, true);
      files.forEach(function (file) {
        if (filter.test(file.path)) {
          liberator.log("Sourcing: " + file.path);
          io.source(file.path, false);
        }
      });
    } else {
      liberator.log("Directory not found: " + dir.path);
    }
  });

  liberator.log('plugin_loader: loaded');
}
