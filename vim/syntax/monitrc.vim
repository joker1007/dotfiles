if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn keyword monitCommand set check include
syn keyword monitSubject directory fifo file filesystem host process system nextgroup=monitIdentifier skipwhite
syn keyword monitKeyword pidfile path nextgroup=monitFilePath skipwhite
syn keyword monitKeyword alert noalert system logfile
syn keyword monitKeyword group failed port checksum start stop restart
syn keyword monitKeyword program daemon space usage
syn keyword monitKeyword timeout restarts within cycles
syn keyword monitCondition if then else
syn keyword monitKeyword depends
syn keyword monitChecksum md5 sha1

syn keyword monitKeyword type nextgroup=monitSocket
syn keyword monitSocket tcp udp tcpssl

syn keyword monitKeyword proto protocol nextgroup=monitProtocol
syn keyword monitProtocol https ssl http ftp smtp pop ntp3 nntp imap clamav ssh dwp ldap2 ldap3 tns contained

syn keyword monitKeyword logfile syslog address enable disable pemfile allow read-only check init count pidfile statefile group start stop uid gid connection port portnumber unix unixsocket mail-format resource expect send mailserver every mode active passive manual depends host default request cpu mem totalmem children loadavg timestamp changed second seconds minute minutes hour hours day days inode pid ppid perm permission icmp process file directory filesystem size action unmonitor rdate rsync data invalid exec nonexist policy reminder instance eventqueue basedir slot slots system idfile gps radius secret target maxforward hostheader
syn keyword monitNoise is as are on only with within and has using use the sum program programs than for usage was but of

syn keyword monitKeyword url nextgroup=monitUrl
syn match monitUrl "[a-z]\+://.\+"


syn match monitIdentifier "[a-zA-Z0-9\-\.]\+"
syn match monitFilePath "[/a-zA-Z0-9-\.]\+"
syn match monitNumber "\d\+"
syn match monitComment "#.*$"

syn region monitString start='"' end='"'

hi def link monitCommand Function
hi def link monitComment Comment
hi def link monitCondition Conditional
hi def link monitFilePath Identifier
hi def link monitIdentifier Identifier
hi def link monitKeyword Statement
hi def link monitNoise Normal
hi def link monitNumber Number
hi def link monitProtocol Structure
hi def link monitString String
hi def link monitSubject Type

let b:current_syntax = "monitrc"

let &cpo = s:cpo_save
unlet s:cpo_save
