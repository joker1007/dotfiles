/**
 * Vimperator plugin
 *
 * proxy setting plugin (for Vimperator 0.6pre)
 *
 * @author cho45
 * @author halt feits
 * @version 0.6
 */

(function() {

    const proxy_settings = [
        {
            conf_name: 'disable',
            conf_usage: 'direct connection',
            settings: [
                {
                    label: 'type',
                    param: 0
                }
            ]
        },
        {
            conf_name: 'polipo',
            conf_usage: 'use polipo cache proxy',
            settings: [
                {
                    label: 'type',
                    param: 1
                },
                {
                    label: 'http',
                    param: '192.168.0.4'
                },
                {
                    label: 'http_port',
                    param: 8123
                }
            ]
        },
        {
            conf_name: 'polipo-autoconf',
            conf_usage: 'use polipo cache proxy',
            settings: [
                {
                    label: 'type',
                    param: 2
                }
            ]
        }
    ];

    liberator.commands.addUserCommand(["proxy"], 'Proxy settings', function (args) {
        const prefs = Components.classes["@mozilla.org/preferences-service;1"]
                                .getService(Components.interfaces.nsIPrefService);
        var name = args;
        if (!name) {
            liberator.echo("Usage: proxy {setting name}");
        }
        proxy_settings.some(function (proxy_setting) {
            if (proxy_setting.conf_name.toLowerCase() != name.toLowerCase()) {
                return false;
            }

            //delete setting
            ['http', 'ssl', 'ftp', 'gopher'].forEach(function (scheme_name) {
                prefs.setCharPref("network.proxy." + scheme_name, '');
                prefs.setIntPref("network.proxy." + scheme_name + "_port", 0);
            });

            proxy_setting.settings.forEach(function (conf) {
                liberator.options.setPref('network.proxy.' + conf.label, conf.param);
            });

            liberator.echo("Set config: " + name);
            return true;
        });
    },
    {
        completer: function (filter) {
            var completions = [];
            var exp = new RegExp("^" + filter);

            for each (let { conf_name: name, conf_usage: usage } in proxy_settings) {
                if (exp.test(name)) {
                    completions.push([name, usage]);
                }
            }

            return [0, completions];
        }
    });

})();
// vim: set sw=4 ts=4 et:
