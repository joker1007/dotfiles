// Vimperator plugin: "Update Twitter & Wassr"
// Last Change: 20-Oct-2008. Jan 2008
// License: Public domain
// Maintainer: mattn <mattn.jp@gmail.com> - http://mattn.kaoriya.net/

(function(){
    liberator.modules.commands.addUserCommand(["twissr"], "Change Twitter & Wassr status",
        function(arg){
            arg = (arg.bang ? '! ' : ' ') + arg.string;
            liberator.execute('twitter' + arg);
            liberator.execute('wassr' + arg);
        },
    { });
})();
