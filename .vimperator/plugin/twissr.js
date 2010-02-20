// Vimperator plugin: "Update Twitter & Wassr"
// Last Change: 17-Sep-2009. Jan 2008
// License: Public domain
// Maintainer: mattn <mattn.jp@gmail.com> - http://mattn.kaoriya.net/

(function(){
    liberator.modules.commands.addUserCommand(["twissr"], "Change Twitter & Wassr status",
        function(arg, special){
            arg = (special ? '! ' : ' ') + arg.string;
            liberator.execute('twitter' + arg);
            liberator.execute('mixiecho' + arg);
            liberator.execute('wassr' + arg);
        },
    { });
})();
