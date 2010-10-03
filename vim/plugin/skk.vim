" vim: set sw=2 fdm=marker nowrap et:
"
" skk.vim
"
" Author: Noriaki Yagi <no_yag@yahoo.co.jp>
" Version: $Id: skk.vim,v 0.22 2006/10/11 09:26:53 noriaki Exp noriaki $
" Last Change: 2010-09-03.
"
" 使い方:
" skk_jisyo および skk_large_jisyo を適宜変更する。
" :so skk.vim
" Insert Mode で <C-j> (デフォルトでは) を押すと skk が起動する。
"
" 最初のもたつきは :call SkkAddRulesSection() を実行するとコンパイル済のデータ
" をこのファイルに書き込むのでだいぶストレスが減る。ただしローマ字のルールを変
" 更してもその変更は反映されないので、一回 :call SkkDeleteRulesSection() を実
" 行して次回起動時以降に SkkAddRulesSection() を実行する必要がある。
"
" TODO Insertモードで <Esc> をマップするとコンソールで矢印キーが使えない。
" TODO 辞書の候補に Lisp の式が書かれている場合の処理
" TODO undo がぐちゃぐちゃになる。
" TODO vim7 で ff=mac の辞書は読み込み・書き込みが遅い。

scriptencoding utf-8

" プラグインの無効化
if exists('plugin_skk_disable')
  finish
endif

if exists("skk_loaded")
  finish
endif
let skk_loaded = 1

let g:skk_version = '0.26'
let g:skk_minor_version = '2'

let s:cpo_save = &cpo
set cpo&vim

"let skk_debug = 1

" Global variables {{{

if !exists("skk_jisyo")
  let skk_jisyo = "~/.skk-jisyo"
endif

if !exists("skk_backup_jisyo")
  let skk_backup_jisyo = skk_jisyo . ".BAK"
endif

if !exists("skk_auto_save_jisyo")
  let skk_auto_save_jisyo = 0
endif

if !exists("skk_manual_save_jisyo_keys")
  let skk_manual_save_jisyo_keys = "gS"
endif

if !exists("skk_large_jisyo")
  let skk_large_jisyo = "/usr/local/share/skk/SKK-JISYO.L"
endif

if !exists("skk_external_prog")
  let skk_external_prog = ""
endif

if !exists("skk_control_j_key")
  let skk_control_j_key = "<C-j>"
endif

if !exists("skk_abbrev_to_zenei_key")
  let skk_abbrev_to_zenei_key = "<C-q>"
endif

if !exists("skk_keep_state")
  let skk_keep_state = 0
endif

if !exists("skk_initial_mode")
  let skk_initial_mode = 'hira'
endif

if !exists("skk_marker_white")
  let skk_marker_white = '▽'
endif

if !exists("skk_marker_black")
  let skk_marker_black = '▼'
endif

if !exists("skk_marker_okuri")
  let skk_marker_okuri = '*'
endif

if !exists("skk_start_henkan_key")
  let skk_start_henkan_key = " "
endif

if !exists("skk_prev_cand_key")
  let skk_prev_cand_key = "x"
endif

if !exists("skk_purge_cand_key")
  let skk_purge_cand_key = "X"
endif

if !exists('skk_enable_jlod_layout')
  let skk_enable_jlod_layout = 0
endif

if !exists("skk_henkan_point_keys")
  if g:skk_enable_jlod_layout
    let skk_henkan_point_keys = 'ABCDEFGHIJKMNOPQRSTUVWXZ":<>'
  else
    let skk_henkan_point_keys = 'ABCDEFGHIJKMNOPRSTUVWYZ'
  endif
endif

if !exists("skk_select_cand_keys")
  if g:skk_enable_jlod_layout
    let skk_select_cand_keys = "AOEUHTNS"
  else
    let skk_select_cand_keys = "ASDFJKL"
  endif
endif

if !exists("skk_show_candidates_count")
  let skk_show_candidates_count = 4
endif

if !exists("skk_completion_key")
  let skk_completion_key = "\<Tab>"
endif

if !exists("skk_next_comp_key")
  let skk_next_comp_key = "."
endif

if !exists("skk_prev_comp_key")
  let skk_prev_comp_key = ","
endif

if !exists("skk_special_midasi_keys")
  let skk_special_midasi_keys = "<>?"
endif

if !exists("skk_kutouten_type")
  let skk_kutouten_type = "jp"
endif

if !exists("skk_kutouten_jp")
  let skk_kutouten_jp = "。、"
endif

if !exists("skk_kutouten_en")
  let skk_kutouten_en = "．，"
endif

if !exists("skk_use_numeric_conversion")
  let skk_use_numeric_conversion = 1
endif

if !exists("skk_egg_like_newline")
  let skk_egg_like_newline = 0
endif

if !exists("skk_show_annotation")
  let skk_show_annotation = 0
endif

if !exists("skk_use_face")
  let skk_use_face = 0
endif

if !exists("skk_autofill_toggle_key")
  let skk_autofill_toggle_key = "<C-k>"
endif

if !exists("skk_rom_kana_rules")
  if g:skk_enable_jlod_layout
    let skk_rom_kana_rules = ""
          \. "!	!\<NL>"
          \. "'	っ	ッ\<NL>"
          \. "-	ー\<NL>"
          \. ";	あん	アン\<NL>"
          \. "?	?\<NL>"
          \. "[	「\<NL>"
          \. "]	」\<NL>"
          \. "a	あ	ア\<NL>"
          \. "b'	ばい	バイ\<NL>"
          \. "b,	ぼう	ボウ\<NL>"
          \. "b.	べい	ベイ\<NL>"
          \. "b;	ばん	バン\<NL>"
          \. "ba	ば	バ\<NL>"
          \. "bb'	ばく	バク\<NL>"
          \. "bb,	ぼく	ボク\<NL>"
          \. "bb.	べき	ベキ\<NL>"
          \. "bb;	ばっ	バッ\<NL>"
          \. "bba	ばつ	バツ\<NL>"
          \. "bbe	べつ	ベツ\<NL>"
          \. "bbi	びつ	ビツ\<NL>"
          \. "bbj	べっ	ベッ\<NL>"
          \. "bbk	ぶっ	ブッ\<NL>"
          \. "bbo	ぼつ	ボツ\<NL>"
          \. "bbp	ぶく	ブク\<NL>"
          \. "bbq	ぼっ	ボッ\<NL>"
          \. "bbu	ぶつ	ブツ\<NL>"
          \. "bbx	びっ	ビッ\<NL>"
          \. "bby	びく	ビク\<NL>"
          \. "be	べ	ベ\<NL>"
          \. "bi	び	ビ\<NL>"
          \. "bj	べん	ベン\<NL>"
          \. "bk	ぶん	ブン\<NL>"
          \. "bo	ぼ	ボ\<NL>"
          \. "bp	ぶう	ブウ\<NL>"
          \. "bq	ぼん	ボン\<NL>"
          \. "bs	びょう	ビョウ\<NL>"
          \. "bu	ぶ	ブ\<NL>"
          \. "bv'	びゃい	ビャイ\<NL>"
          \. "bv,	びょう	ビョウ\<NL>"
          \. "bv.	びぇい	ビェイ\<NL>"
          \. "bv;	びゃん	ビャン\<NL>"
          \. "bva	びゃ	ビャ\<NL>"
          \. "bve	びぇ	ビェ\<NL>"
          \. "bvi	びぃ	ビィ\<NL>"
          \. "bvj	びぇん	ビェン\<NL>"
          \. "bvk	びゅん	ビュン\<NL>"
          \. "bvm	びゅく	ビュク\<NL>"
          \. "bvo	びょ	ビョ\<NL>"
          \. "bvp	びゅう	ビュウ\<NL>"
          \. "bvq	びょん	ビョン\<NL>"
          \. "bvu	びゅ	ビュ\<NL>"
          \. "bvv	びょく	ビョク\<NL>"
          \. "bvw	びゅつ	ビュツ\<NL>"
          \. "bvx	びぃん	ビィン\<NL>"
          \. "bvy	びゅい	ビュイ\<NL>"
          \. "bvz	びゃく	ビャク\<NL>"
          \. "bw	びゅう	ビュウ\<NL>"
          \. "bx	びん	ビン\<NL>"
          \. "by	ぶい	ブイ\<NL>"
          \. "by	ぶい	ブイ\<NL>"
          \. "bz	びょう	ビョウ\<NL>"
          \. "c'	かい	カイ\<NL>"
          \. "c,	こう	コウ\<NL>"
          \. "c.	けい	ケイ\<NL>"
          \. "c;	かん	カン\<NL>"
          \. "ca	か	カ\<NL>"
          \. "cc	きゅう	キュウ\<NL>"
          \. "ce	け	ケ\<NL>"
          \. "cf'	かく	カク\<NL>"
          \. "cf,	こく	コク\<NL>"
          \. "cf.	けき	ケキ\<NL>"
          \. "cf;	かっ	カッ\<NL>"
          \. "cfa	かつ	カツ\<NL>"
          \. "cfe	けつ	ケツ\<NL>"
          \. "cfi	きつ	キツ\<NL>"
          \. "cfj	けっ	ケッ\<NL>"
          \. "cfk	くっ	クッ\<NL>"
          \. "cfo	こつ	コツ\<NL>"
          \. "cfp	くく	クク\<NL>"
          \. "cfq	こっ	コッ\<NL>"
          \. "cfu	くつ	クツ\<NL>"
          \. "cfx	きっ	キッ\<NL>"
          \. "cfy	きく	キク\<NL>"
          \. "cg'	きゃい	キャイ\<NL>"
          \. "cg,	きょう	キョウ\<NL>"
          \. "cg.	きぇい	キェイ\<NL>"
          \. "cg;	きゃん	キャン\<NL>"
          \. "cga	きゃ	キャ\<NL>"
          \. "cgc	きゅつ	キュツ\<NL>"
          \. "cge	きぇ	キェ\<NL>"
          \. "cgg	きゅく	キュク\<NL>"
          \. "cgi	きぃ	キィ\<NL>"
          \. "cgj	きぇん	キェン\<NL>"
          \. "cgk	きゅん	キュン\<NL>"
          \. "cgl	きゃく	キャク\<NL>"
          \. "cgo	きょ	キョ\<NL>"
          \. "cgp	きゅう	キュウ\<NL>"
          \. "cgq	きょん	キョン\<NL>"
          \. "cgr	きょく	キョク\<NL>"
          \. "cgu	きゅ	キュ\<NL>"
          \. "cgx	きぃん	キィン\<NL>"
          \. "cgy	きゅい	キュイ\<NL>"
          \. "ci	き	キ\<NL>"
          \. "cj	けん	ケン\<NL>"
          \. "ck	くん	クン\<NL>"
          \. "cl	きょう	キョウ\<NL>"
          \. "co	こ	コ\<NL>"
          \. "cp	くう	クウ\<NL>"
          \. "cq	こん	コン\<NL>"
          \. "cu	く	ク\<NL>"
          \. "cx	きん	キン\<NL>"
          \. "cy	くい	クイ\<NL>"
          \. "cy	くい	クイ\<NL>"
          \. "d'	だい	ダイ\<NL>"
          \. "d,	どう	ドウ\<NL>"
          \. "d.	でい	デイ\<NL>"
          \. "d;	だん	ダン\<NL>"
          \. "da	だ	ダ\<NL>"
          \. "dd'	だく	ダク\<NL>"
          \. "dd,	どく	ドク\<NL>"
          \. "dd.	でき	デキ\<NL>"
          \. "dd;	だっ	ダッ\<NL>"
          \. "dda	だつ	ダツ\<NL>"
          \. "dde	でつ	デツ\<NL>"
          \. "ddi	ぢつ	ヂツ\<NL>"
          \. "ddj	でっ	デッ\<NL>"
          \. "ddk	づっ	ヅッ\<NL>"
          \. "ddo	どつ	ドツ\<NL>"
          \. "ddp	づく	ヅク\<NL>"
          \. "ddq	どっ	ドッ\<NL>"
          \. "ddu	づつ	ヅツ\<NL>"
          \. "ddx	ぢっ	ヂッ\<NL>"
          \. "ddy	ぢく	ヂク\<NL>"
          \. "de	で	デ\<NL>"
          \. "dh'	でゃう	デャウ\<NL>"
          \. "dh,	でょう	デョウ\<NL>"
          \. "dh.	でぇい	デェイ\<NL>"
          \. "dh;	でゃん	デャン\<NL>"
          \. "dha	でゃ	デャ\<NL>"
          \. "dhe	でぇ	デェ\<NL>"
          \. "dhi	でぃ	ディ\<NL>"
          \. "dhj	でぇん	デェン\<NL>"
          \. "dhk	でゅん	デュン\<NL>"
          \. "dho	でょ	デョ\<NL>"
          \. "dhp	でゅう	デュウ\<NL>"
          \. "dhq	でょん	デョン\<NL>"
          \. "dhu	でゅ	デュ\<NL>"
          \. "dhx	でぃん	ディン\<NL>"
          \. "dhy	でゅい	デュイ\<NL>"
          \. "di	ぢ	ヂ\<NL>"
          \. "dj	でん	デン\<NL>"
          \. "dk	づん	ヅン\<NL>"
          \. "dn'	ぢゃい	ヂャイ\<NL>"
          \. "dn,	ぢょう	ヂョウ\<NL>"
          \. "dn.	ぢぇい	ヂェイ\<NL>"
          \. "dn;	ぢゃん	ヂャン\<NL>"
          \. "dna	ぢゃ	ヂャ\<NL>"
          \. "dne	ぢぇ	ヂェ\<NL>"
          \. "dnh	ぢゅく	ヂュク\<NL>"
          \. "dni	ぢぃ	ヂィ\<NL>"
          \. "dnj	ぢぇん	ヂェン\<NL>"
          \. "dnk	ぢゅん	ヂュン\<NL>"
          \. "dnn	ぢょく	ヂョク\<NL>"
          \. "dno	ぢょ	ヂョ\<NL>"
          \. "dnp	ぢゅう	ヂュウ\<NL>"
          \. "dnq	ぢょん	ヂョン\<NL>"
          \. "dns	ぢゃく	ヂャク\<NL>"
          \. "dnt	ぢゅつ	ヂュツ\<NL>"
          \. "dnu	ぢゅ	ヂュ\<NL>"
          \. "dnx	ぢぃん	ヂィン\<NL>"
          \. "dny	ぢゅい	ヂュイ\<NL>"
          \. "do	ど	ド\<NL>"
          \. "dp	づう	ヅウ\<NL>"
          \. "dq	どん	ドン\<NL>"
          \. "ds	ぢょう	ヂョウ\<NL>"
          \. "dt	ぢゅう	ヂュウ\<NL>"
          \. "du	づ	ヅ\<NL>"
          \. "dx	ぢん	ヂン\<NL>"
          \. "dy	づい	ヅイ\<NL>"
          \. "dy	づい	ヅイ\<NL>"
          \. "e	え	エ\<NL>"
          \. "f'	ぱい	パイ\<NL>"
          \. "f,	ぽう	ポウ\<NL>"
          \. "f.	ぺい	ペイ\<NL>"
          \. "f;	ぱん	パン\<NL>"
          \. "fa	ぱ	パ\<NL>"
          \. "fc	ぴゅう	ピュウ\<NL>"
          \. "fc	ふゅー	フュー\<NL>"
          \. "fe	ぺ	ペ\<NL>"
          \. "ff'	ぱく	パク\<NL>"
          \. "ff,	ぽく	ポク\<NL>"
          \. "ff.	ぺき	ペキ\<NL>"
          \. "ff;	ぱっ	パッ\<NL>"
          \. "ffa	ぱつ	パツ\<NL>"
          \. "ffe	ぺつ	ペツ\<NL>"
          \. "ffi	ぴつ	ピツ\<NL>"
          \. "ffj	ぺっ	ペッ\<NL>"
          \. "ffk	ぷっ	プッ\<NL>"
          \. "ffo	ぽつ	ポツ\<NL>"
          \. "ffp	ぷく	プク\<NL>"
          \. "ffq	ぽっ	ポッ\<NL>"
          \. "ffu	ぷつ	プツ\<NL>"
          \. "ffx	ぴっ	ピッ\<NL>"
          \. "ffy	ぴく	ピク\<NL>"
          \. "fi	ぴ	ピ\<NL>"
          \. "fj	ぺん	ペン\<NL>"
          \. "fk	ぷん	プン\<NL>"
          \. "fl	ぴょう	ピョウ\<NL>"
          \. "fo	ぽ	ポ\<NL>"
          \. "fp	ぷう	プウ\<NL>"
          \. "fq	ぽん	ポン\<NL>"
          \. "fr'	ぴゃい	ピャイ\<NL>"
          \. "fr,	ぴょう	ピョウ\<NL>"
          \. "fr.	ぴぇい	ピェイ\<NL>"
          \. "fr;	ぴゃん	ピャン\<NL>"
          \. "fra	ぴゃ	ピャ\<NL>"
          \. "frc	ぴゅつ	ピュツ\<NL>"
          \. "fre	ぴぇ	ピェ\<NL>"
          \. "frg	ぴゅく	ピュク\<NL>"
          \. "fri	ぴぃ	ピィ\<NL>"
          \. "frj	ぴぇん	ピェン\<NL>"
          \. "frk	ぴゅん	ピュン\<NL>"
          \. "frl	ぴゃく	ピャク\<NL>"
          \. "fro	ぴょ	ピョ\<NL>"
          \. "frp	ぴゅう	ピュウ\<NL>"
          \. "frq	ぴょん	ピョン\<NL>"
          \. "frr	ぴょく	ピョク\<NL>"
          \. "fru	ぴゅ	ピュ\<NL>"
          \. "frx	ぴぃん	ピィン\<NL>"
          \. "fry	ぴゅい	ピュイ\<NL>"
          \. "fu	ぷ	プ\<NL>"
          \. "fx	ぴん	ピン\<NL>"
          \. "fy	ふい	フイ\<NL>"
          \. "fy	ぷい	プイ\<NL>"
          \. "fy	ぷい	プイ\<NL>"
          \. "g'	がい	ガイ\<NL>"
          \. "g,	ごう	ゴウ\<NL>"
          \. "g.	げい	ゲイ\<NL>"
          \. "g;	がん	ガン\<NL>"
          \. "ga	が	ガ\<NL>"
          \. "gc	ぎゅう	ギュウ\<NL>"
          \. "ge	げ	ゲ\<NL>"
          \. "gf'	がく	ガク\<NL>"
          \. "gf,	ごく	ゴク\<NL>"
          \. "gf.	げき	ゲキ\<NL>"
          \. "gf;	がっ	ガッ\<NL>"
          \. "gfa	がつ	ガツ\<NL>"
          \. "gfe	げつ	ゲツ\<NL>"
          \. "gfi	ぎつ	ギツ\<NL>"
          \. "gfj	げっ	ゲッ\<NL>"
          \. "gfk	ぐっ	グッ\<NL>"
          \. "gfo	ごつ	ゴツ\<NL>"
          \. "gfp	ぐく	グク\<NL>"
          \. "gfq	ごっ	ゴッ\<NL>"
          \. "gfu	ぐつ	グツ\<NL>"
          \. "gfx	ぎっ	ギッ\<NL>"
          \. "gfy	ぎく	ギク\<NL>"
          \. "gi	ぎ	ギ\<NL>"
          \. "gj	げん	ゲン\<NL>"
          \. "gk	ぐん	グン\<NL>"
          \. "gl	ぎょう	ギョウ\<NL>"
          \. "go	ご	ゴ\<NL>"
          \. "gp	ぐう	グウ\<NL>"
          \. "gq	ごん	ゴン\<NL>"
          \. "gr'	ぎゃい	ギャイ\<NL>"
          \. "gr,	ぎょう	ギョウ\<NL>"
          \. "gr.	ぎぇい	ギェイ\<NL>"
          \. "gr;	ぎゃん	ギャン\<NL>"
          \. "gra	ぎゃ	ギャ\<NL>"
          \. "grc	ぎゅつ	ギュツ\<NL>"
          \. "gre	ぎぇ	ギェ\<NL>"
          \. "grg	ぎゅく	ギュク\<NL>"
          \. "gri	ぎぃ	ギィ\<NL>"
          \. "grj	ぎぇん	ギェン\<NL>"
          \. "grk	ぎゅん	ギュン\<NL>"
          \. "grl	ぎゃく	ギャク\<NL>"
          \. "gro	ぎょ	ギョ\<NL>"
          \. "grp	ぎゅう	ギュウ\<NL>"
          \. "grq	ぎょん	ギョン\<NL>"
          \. "grr	ぎょく	ギョク\<NL>"
          \. "gru	ぎゅ	ギュ\<NL>"
          \. "grx	ぎぃん	ギィン\<NL>"
          \. "gry	ぎゅい	ギュイ\<NL>"
          \. "gu	ぐ	グ\<NL>"
          \. "gx	ぎん	ギン\<NL>"
          \. "gy	ぐい	グイ\<NL>"
          \. "gy	ぐい	グイ\<NL>"
          \. "h'	はい	ハイ\<NL>"
          \. "h,	ほう	ホウ\<NL>"
          \. "h.	へい	ヘイ\<NL>"
          \. "h;	はん	ハン\<NL>"
          \. "ha	は	ハ\<NL>"
          \. "hd'	はく	ハク\<NL>"
          \. "hd,	ほく	ホク\<NL>"
          \. "hd.	へき	ヘキ\<NL>"
          \. "hd;	はっ	ハッ\<NL>"
          \. "hda	はつ	ハツ\<NL>"
          \. "hde	へつ	ヘツ\<NL>"
          \. "hdi	ひつ	ヒツ\<NL>"
          \. "hdj	へっ	ヘッ\<NL>"
          \. "hdk	ふっ	フッ\<NL>"
          \. "hdo	ほつ	ホツ\<NL>"
          \. "hdp	ふく	フク\<NL>"
          \. "hdq	ほっ	ホッ\<NL>"
          \. "hdu	ふつ	フツ\<NL>"
          \. "hdx	ひっ	ヒッ\<NL>"
          \. "hdy	ひく	ヒク\<NL>"
          \. "he	へ	ヘ\<NL>"
          \. "hh'	ふぁい	ファイ\<NL>"
          \. "hh,	ふぉー	フォー\<NL>"
          \. "hh.	ふぇい	フェイ\<NL>"
          \. "hh;	ふぁん	ファン\<NL>"
          \. "hha	ふぁ	ファ\<NL>"
          \. "hhe	ふぇ	フェ\<NL>"
          \. "hhi	ふぃ	フィ\<NL>"
          \. "hhj	ふぇん	フェン\<NL>"
          \. "hhk	ふん	フン\<NL>"
          \. "hho	ふぉ	フォ\<NL>"
          \. "hhp	ふう	フウ\<NL>"
          \. "hhq	ふぉん	フォン\<NL>"
          \. "hhu	ふ	フ\<NL>"
          \. "hhx	ふぃん	フィン\<NL>"
          \. "hi	ひ	ヒ\<NL>"
          \. "hj	へん	ヘン\<NL>"
          \. "hk	ふん	フン\<NL>"
          \. "hn'	ひゃい	ヒャイ\<NL>"
          \. "hn,	ひょう	ヒョウ\<NL>"
          \. "hn.	ひぇい	ヒェイ\<NL>"
          \. "hn;	ひゃん	ヒャン\<NL>"
          \. "hna	ひゃ	ヒャ\<NL>"
          \. "hne	ひぇ	ヒェ\<NL>"
          \. "hnh	ひゅく	ヒュク\<NL>"
          \. "hni	ひぃ	ヒィ\<NL>"
          \. "hnj	ひぇん	ヒェン\<NL>"
          \. "hnk	ひゅん	ヒュン\<NL>"
          \. "hnn	ひょく	ヒョク\<NL>"
          \. "hno	ひょ	ヒョ\<NL>"
          \. "hnp	ひゅう	ヒュウ\<NL>"
          \. "hnq	ひょん	ヒョン\<NL>"
          \. "hns	ひゃく	ヒャク\<NL>"
          \. "hnt	ひゅつ	ヒュツ\<NL>"
          \. "hnu	ひゅ	ヒュ\<NL>"
          \. "hnx	ひぃん	ヒィン\<NL>"
          \. "hny	ひゅい	ヒュイ\<NL>"
          \. "ho	ほ	ホ\<NL>"
          \. "hp	ふう	フウ\<NL>"
          \. "hq	ほん	ホン\<NL>"
          \. "hs	ひょう	ヒョウ\<NL>"
          \. "ht	ひゅう	ヒュウ\<NL>"
          \. "hu	ふ	フ\<NL>"
          \. "hx	ひん	ヒン\<NL>"
          \. "hy	ふい	フイ\<NL>"
          \. "hy	ふい	フイ\<NL>"
          \. "i	い	イ\<NL>"
          \. "j	えん	エン\<NL>"
          \. "k	うん	ウン\<NL>"
          \. "la	ぁ	ァ\<NL>"
          \. "lca	か	ヵ\<NL>"
          \. "lce	け	ヶ\<NL>"
          \. "le	ぇ	ェ\<NL>"
          \. "li	ぃ	ィ\<NL>"
          \. "lo	ぉ	ォ\<NL>"
          \. "ltu	っ	ッ\<NL>"
          \. "lu	ぅ	ゥ\<NL>"
          \. "lva	ゃ	ャ\<NL>"
          \. "lvo	ょ	ョ\<NL>"
          \. "lvu	ゅ	ュ\<NL>"
          \. "lwa	ゎ	ヮ\<NL>"
          \. "lwe	ゑ	ヱ\<NL>"
          \. "lwi	ゐ	ヰ\<NL>"
          \. "m'	まい	マイ\<NL>"
          \. "m,	もう	モウ\<NL>"
          \. "m.	めい	メイ\<NL>"
          \. "m;	まん	マン\<NL>"
          \. "ma	ま	マ\<NL>"
          \. "mb'	まく	マク\<NL>"
          \. "mb,	もく	モク\<NL>"
          \. "mb.	めき	メキ\<NL>"
          \. "mb;	まっ	マッ\<NL>"
          \. "mba	まつ	マツ\<NL>"
          \. "mbe	めつ	メツ\<NL>"
          \. "mbi	みつ	ミツ\<NL>"
          \. "mbj	めっ	メッ\<NL>"
          \. "mbk	むっ	ムッ\<NL>"
          \. "mbo	もつ	モツ\<NL>"
          \. "mbp	むく	ムク\<NL>"
          \. "mbq	もっ	モッ\<NL>"
          \. "mbu	むつ	ムツ\<NL>"
          \. "mbx	みっ	ミッ\<NL>"
          \. "mby	みく	ミク\<NL>"
          \. "me	め	メ\<NL>"
          \. "mi	み	ミ\<NL>"
          \. "mj	めん	メン\<NL>"
          \. "mk	むん	ムン\<NL>"
          \. "mo	も	モ\<NL>"
          \. "mp	むう	ムウ\<NL>"
          \. "mq	もん	モン\<NL>"
          \. "mu	む	ム\<NL>"
          \. "mv'	みゃい	ミャイ\<NL>"
          \. "mv,	みょう	ミョウ\<NL>"
          \. "mv.	みぇい	ミェイ\<NL>"
          \. "mv;	みゃん	ミャン\<NL>"
          \. "mva	みゃ	ミャ\<NL>"
          \. "mve	みぇ	ミェ\<NL>"
          \. "mvi	みぃ	ミィ\<NL>"
          \. "mvj	みぇん	ミェン\<NL>"
          \. "mvk	みゅん	ミュン\<NL>"
          \. "mvm	みゅく	ミュク\<NL>"
          \. "mvo	みょ	ミョ\<NL>"
          \. "mvp	みゅう	ミュウ\<NL>"
          \. "mvq	みょん	ミョン\<NL>"
          \. "mvu	みゅ	ミュ\<NL>"
          \. "mvv	みょく	ミョク\<NL>"
          \. "mvw	みゅつ	ミュツ\<NL>"
          \. "mvx	みぃん	ミィン\<NL>"
          \. "mvz	みゃく	ミャク\<NL>"
          \. "mw	みゅう	ミュウ\<NL>"
          \. "mx	みん	ミン\<NL>"
          \. "my	むい	ムイ\<NL>"
          \. "my	むい	ムイ\<NL>"
          \. "mz	みょう	ミョウ\<NL>"
          \. "n'	ない	ナイ\<NL>"
          \. "n,	のう	ノウ\<NL>"
          \. "n.	ねい	ネイ\<NL>"
          \. "n;	なん	ナン\<NL>"
          \. "na	な	ナ\<NL>"
          \. "nd'	なく	ナク\<NL>"
          \. "nd,	のく	ノク\<NL>"
          \. "nd.	ねき	ネキ\<NL>"
          \. "nd;	なっ	ナッ\<NL>"
          \. "nda	なつ	ナツ\<NL>"
          \. "nde	ねつ	ネツ\<NL>"
          \. "ndi	につ	ニツ\<NL>"
          \. "ndj	ねっ	ネッ\<NL>"
          \. "ndk	ぬっ	ヌッ\<NL>"
          \. "ndo	のつ	ノツ\<NL>"
          \. "ndp	ぬく	ヌク\<NL>"
          \. "ndq	のっ	ノッ\<NL>"
          \. "ndu	ぬつ	ヌツ\<NL>"
          \. "ndx	にっ	ニッ\<NL>"
          \. "ndy	にく	ニク\<NL>"
          \. "ne	ね	ネ\<NL>"
          \. "nh'	にゃい	ニャイ\<NL>"
          \. "nh,	にょう	ニョウ\<NL>"
          \. "nh.	にぇい	ニェイ\<NL>"
          \. "nh;	にゃん	ニャン\<NL>"
          \. "nha	にゃ	ニャ\<NL>"
          \. "nhe	にぇ	ニェ\<NL>"
          \. "nhh	にゅく	ニュク\<NL>"
          \. "nhi	にぃ	ニィ\<NL>"
          \. "nhj	にぇん	ニェン\<NL>"
          \. "nhk	にゅん	ニュン\<NL>"
          \. "nhn	にょく	ニョク\<NL>"
          \. "nho	にょ	ニョ\<NL>"
          \. "nhp	にゅう	ニュウ\<NL>"
          \. "nhq	にょん	ニョン\<NL>"
          \. "nhs	にゃく	ニャク\<NL>"
          \. "nht	にゅつ	ニュツ\<NL>"
          \. "nhu	にゅ	ニュ\<NL>"
          \. "nhx	にぃん	ニィン\<NL>"
          \. "nhy	にゅい	ニュイ\<NL>"
          \. "ni	に	ニ\<NL>"
          \. "nj	ねん	ネン\<NL>"
          \. "nk	ぬん	ヌン\<NL>"
          \. "nn	ん	ン\<NL>"
          \. "no	の	ノ\<NL>"
          \. "np	ぬう	ヌウ\<NL>"
          \. "nq	のん	ノン\<NL>"
          \. "ns	にょう	ニョウ\<NL>"
          \. "nt	にゅう	ニュウ\<NL>"
          \. "nu	ぬ	ヌ\<NL>"
          \. "nx	にん	ニン\<NL>"
          \. "ny	ぬい	ヌイ\<NL>"
          \. "ny	ぬい	ヌイ\<NL>"
          \. "o	お	オ\<NL>"
          \. "q	おん	オン\<NL>"
          \. "r'	らい	ライ\<NL>"
          \. "r,	ろう	ロウ\<NL>"
          \. "r.	れい	レイ\<NL>"
          \. "r;	らん	ラン\<NL>"
          \. "ra	ら	ラ\<NL>"
          \. "rc	りゅう	リュウ\<NL>"
          \. "re	れ	レ\<NL>"
          \. "rf'	らく	ラク\<NL>"
          \. "rf,	ろく	ロク\<NL>"
          \. "rf.	れき	レキ\<NL>"
          \. "rf;	らっ	ラッ\<NL>"
          \. "rfa	らつ	ラツ\<NL>"
          \. "rfe	れつ	レツ\<NL>"
          \. "rfi	りつ	リツ\<NL>"
          \. "rfj	れっ	レッ\<NL>"
          \. "rfk	るっ	ルッ\<NL>"
          \. "rfo	ろつ	ロツ\<NL>"
          \. "rfp	るく	ルク\<NL>"
          \. "rfq	ろっ	ロッ\<NL>"
          \. "rfu	るつ	ルツ\<NL>"
          \. "rfx	りっ	リッ\<NL>"
          \. "rfy	りく	リク\<NL>"
          \. "rg'	りゃい	リャイ\<NL>"
          \. "rg,	りょう	リョウ\<NL>"
          \. "rg.	りぇい	リェイ\<NL>"
          \. "rg;	りゃん	リャン\<NL>"
          \. "rga	りゃ	リャ\<NL>"
          \. "rge	りぇ	リェ\<NL>"
          \. "rge	りゅつ	リュツ\<NL>"
          \. "rgg	りゅく	リュク\<NL>"
          \. "rgi	りぃ	リィ\<NL>"
          \. "rgj	りぇん	リェン\<NL>"
          \. "rgk	りゅん	リュン\<NL>"
          \. "rgl	りゃく	リャク\<NL>"
          \. "rgo	りょ	リョ\<NL>"
          \. "rgp	りゅう	リュウ\<NL>"
          \. "rgq	りょん	リョン\<NL>"
          \. "rgr	りょく	リョク\<NL>"
          \. "rgu	りゅ	リュ\<NL>"
          \. "rgx	りぃん	リィン\<NL>"
          \. "rgy	りゅい	リュイ\<NL>"
          \. "ri	り	リ\<NL>"
          \. "rj	れん	レン\<NL>"
          \. "rk	るん	ルン\<NL>"
          \. "rl	りょう	リョウ\<NL>"
          \. "ro	ろ	ロ\<NL>"
          \. "rp	るう	ルウ\<NL>"
          \. "rq	ろん	ロン\<NL>"
          \. "ru	る	ル\<NL>"
          \. "rx	りん	リン\<NL>"
          \. "ry	るい	ルイ\<NL>"
          \. "ry	るい	ルイ\<NL>"
          \. "s'	さい	サイ\<NL>"
          \. "s,	そう	ソウ\<NL>"
          \. "s.	せい	セイ\<NL>"
          \. "s;	さん	サン\<NL>"
          \. "sa	さ	サ\<NL>"
          \. "sd'	さく	サク\<NL>"
          \. "sd,	そく	ソク\<NL>"
          \. "sd.	せき	セキ\<NL>"
          \. "sd;	さっ	サッ\<NL>"
          \. "sda	さつ	サツ\<NL>"
          \. "sde	せつ	セツ\<NL>"
          \. "sdi	しつ	シツ\<NL>"
          \. "sdj	せっ	セッ\<NL>"
          \. "sdk	すっ	スッ\<NL>"
          \. "sdo	そつ	ソツ\<NL>"
          \. "sdp	すく	スク\<NL>"
          \. "sdq	そっ	ソッ\<NL>"
          \. "sdu	すつ	スツ\<NL>"
          \. "sdx	しっ	シッ\<NL>"
          \. "sdy	しく	シク\<NL>"
          \. "se	せ	セ\<NL>"
          \. "sh'	しゃい	シャイ\<NL>"
          \. "sh,	しょう	ショウ\<NL>"
          \. "sh.	しぇい	シェイ\<NL>"
          \. "sh;	しゃん	シャン\<NL>"
          \. "sha	しゃ	シャ\<NL>"
          \. "she	しぇ	シェ\<NL>"
          \. "shh	しゅく	シュク\<NL>"
          \. "shi	しぃ	シィ\<NL>"
          \. "shj	しぇん	シェン\<NL>"
          \. "shk	しゅん	シュン\<NL>"
          \. "shn	しょく	ショク\<NL>"
          \. "sho	しょ	ショ\<NL>"
          \. "shp	しゅう	シュウ\<NL>"
          \. "shq	しょん	ション\<NL>"
          \. "shs	しゃく	シャク\<NL>"
          \. "sht	しゅつ	シュツ\<NL>"
          \. "shu	しゅ	シュ\<NL>"
          \. "shx	しぃん	シィン\<NL>"
          \. "shy	しゅい	シュイ\<NL>"
          \. "si	し	シ\<NL>"
          \. "sj	せん	セン\<NL>"
          \. "sk	すん	スン\<NL>"
          \. "so	そ	ソ\<NL>"
          \. "sp	すう	スウ\<NL>"
          \. "sq	そん	ソン\<NL>"
          \. "ss	しょう	ショウ\<NL>"
          \. "st	しゅう	シュウ\<NL>"
          \. "su	す	ス\<NL>"
          \. "sx	しん	シン\<NL>"
          \. "sy	すい	スイ\<NL>"
          \. "sy	すい	スイ\<NL>"
          \. "t'	たい	タイ\<NL>"
          \. "t,	とう	トウ\<NL>"
          \. "t.	てい	テイ\<NL>"
          \. "t;	たん	タン\<NL>"
          \. "ta	た	タ\<NL>"
          \. "td'	たく	タク\<NL>"
          \. "td,	とく	トク\<NL>"
          \. "td.	てき	テキ\<NL>"
          \. "td;	たっ	タッ\<NL>"
          \. "tda	たつ	タツ\<NL>"
          \. "tde	てつ	テツ\<NL>"
          \. "tdi	ちつ	チツ\<NL>"
          \. "tdj	てっ	テッ\<NL>"
          \. "tdk	つっ	ツッ\<NL>"
          \. "tdo	とつ	トツ\<NL>"
          \. "tdp	つく	ツク\<NL>"
          \. "tdq	とっ	トッ\<NL>"
          \. "tdu	つつ	ツツ\<NL>"
          \. "tdx	ちっ	チッ\<NL>"
          \. "tdy	ちく	チク\<NL>"
          \. "te	て	テ\<NL>"
          \. "th'	ちゃい	チャイ\<NL>"
          \. "th,	ちょう	チョウ\<NL>"
          \. "th.	ちぇい	チェイ\<NL>"
          \. "th;	ちゃん	チャン\<NL>"
          \. "tha	ちゃ	チャ\<NL>"
          \. "the	ちぇ	チェ\<NL>"
          \. "thh	ちゅく	チュク\<NL>"
          \. "thi	ちぃ	チィ\<NL>"
          \. "thj	ちぇん	チェン\<NL>"
          \. "thk	ちゅん	チュン\<NL>"
          \. "thn	ちょく	チョク\<NL>"
          \. "tho	ちょ	チョ\<NL>"
          \. "thp	ちゅう	チュウ\<NL>"
          \. "thq	ちょん	チョン\<NL>"
          \. "ths	ちゃく	チャク\<NL>"
          \. "tht	ちゅつ	チュツ\<NL>"
          \. "thu	ちゅ	チュ\<NL>"
          \. "thx	ちぃん	チィン\<NL>"
          \. "thy	ちゅい	チュイ\<NL>"
          \. "ti	ち	チ\<NL>"
          \. "tj	てん	テン\<NL>"
          \. "tk	つん	ツン\<NL>"
          \. "tn'	てゃう	テャウ\<NL>"
          \. "tn,	てょう	テョウ\<NL>"
          \. "tn.	てぇい	テェイ\<NL>"
          \. "tn;	てゃん	テャン\<NL>"
          \. "tna	てゃ	テャ\<NL>"
          \. "tne	てぇ	テェ\<NL>"
          \. "tni	てぃ	ティ\<NL>"
          \. "tnj	てぇん	テェン\<NL>"
          \. "tnk	てゅん	テュン\<NL>"
          \. "tno	てょ	テョ\<NL>"
          \. "tnp	てゅう	テュウ\<NL>"
          \. "tnq	てょん	テョン\<NL>"
          \. "tnu	てゅ	テュ\<NL>"
          \. "tnx	てぃん	ティン\<NL>"
          \. "tny	てゅい	テュイ\<NL>"
          \. "to	と	ト\<NL>"
          \. "tp	つう	ツウ\<NL>"
          \. "tq	とん	トン\<NL>"
          \. "ts	ちょう	チョウ\<NL>"
          \. "tt	ちゅう	チュウ\<NL>"
          \. "tu	つ	ツ\<NL>"
          \. "tx	ちん	チン\<NL>"
          \. "ty	つい	ツイ\<NL>"
          \. "ty	つい	ツイ\<NL>"
          \. "u	う	ウ\<NL>"
          \. "v'	う゛ぁい	ヴァイ\<NL>"
          \. "v'	やい	ヤイ\<NL>"
          \. "v,	よう	ヨウ\<NL>"
          \. "v.	う゛ぇい	ヴェイ\<NL>"
          \. "v;	う゛ぁん	ヴァン\<NL>"
          \. "v;	やん	ヤン\<NL>"
          \. "va	や	ヤ\<NL>"
          \. "vb'	やく	ヤク\<NL>"
          \. "vb,	よく	ヨク\<NL>"
          \. "vb.	いぇき	イェキ\<NL>"
          \. "vb;	やっ	ヤッ\<NL>"
          \. "vba	やつ	ヤツ\<NL>"
          \. "vbe	いぇつ	イェツ\<NL>"
          \. "vbi	いつ	イツ\<NL>"
          \. "vbj	いぇっ	イェッ\<NL>"
          \. "vbk	ゆっ	ユッ\<NL>"
          \. "vbo	よつ	ヨツ\<NL>"
          \. "vbp	ゆく	ユク\<NL>"
          \. "vbq	よっ	ヨッ\<NL>"
          \. "vbu	ゆつ	ユツ\<NL>"
          \. "vbx	いっ	イッ\<NL>"
          \. "vby	いく	イク\<NL>"
          \. "ve	いぇ	イェ\<NL>"
          \. "vi	い	イ\<NL>"
          \. "vj	う゛ぇん	ヴェン\<NL>"
          \. "vk	う゛ん	ヴン\<NL>"
          \. "vk	ゆん	ユン\<NL>"
          \. "vo	よ	ヨ\<NL>"
          \. "vp	う゛ー	ヴー\<NL>"
          \. "vp	ゆう	ユウ\<NL>"
          \. "vq	う゛ぉん	ヴォン\<NL>"
          \. "vq	よん	ヨン\<NL>"
          \. "vu	ゆ	ユ\<NL>"
          \. "vv'	う゛ぁい	ヴァイ\<NL>"
          \. "vv,	う゛ぉー	ヴォー\<NL>"
          \. "vv.	う゛ぇい	ヴェイ\<NL>"
          \. "vv;	う゛ぁん	ヴァン\<NL>"
          \. "vva	う゛ぁ	ヴァ\<NL>"
          \. "vve	う゛ぇ	ヴェ\<NL>"
          \. "vvi	う゛ぃ	ヴィ\<NL>"
          \. "vvj	う゛ぇん	ヴェン\<NL>"
          \. "vvk	う゛ん	ヴン\<NL>"
          \. "vvo	う゛ぉ	ヴォ\<NL>"
          \. "vvp	う゛ー	ヴー\<NL>"
          \. "vvq	う゛ぉん	ヴォン\<NL>"
          \. "vvu	う゛	ヴ\<NL>"
          \. "vvw	う゛ゅー	ヴュー\<NL>"
          \. "vvx	う゛ぃん	ヴィン\<NL>"
          \. "vvz	う゛ぉー	ヴォー\<NL>"
          \. "vw	う゛ゅー	ヴュー\<NL>"
          \. "vx	う゛ぃん	ヴィン\<NL>"
          \. "vy	う゛い	ヴイ\<NL>"
          \. "vy	う゛い	ヴイ\<NL>"
          \. "vy	ゆい	ユイ\<NL>"
          \. "vz	う゛ぉー	ヴォー\<NL>"
          \. "w'	わい	ワイ\<NL>"
          \. "w,	うぉう	ウォウ\<NL>"
          \. "w.	うぇい	ウェイ\<NL>"
          \. "w;	わん	ワン\<NL>"
          \. "wa	わ	ワ\<NL>"
          \. "wb'	わく	ワク\<NL>"
          \. "wb,	をく	ヲク\<NL>"
          \. "wb.	うぇき	ウェキ\<NL>"
          \. "wb;	わっ	ワッ\<NL>"
          \. "wba	わつ	ワツ\<NL>"
          \. "wbe	うぇつ	ウェツ\<NL>"
          \. "wbi	うぃつ	ウィツ\<NL>"
          \. "wbj	うぇっ	ウェッ\<NL>"
          \. "wbk	うっ	ウッ\<NL>"
          \. "wbo	をつ	ヲツ\<NL>"
          \. "wbp	うく	ウク\<NL>"
          \. "wbq	をっ	ヲッ\<NL>"
          \. "wbu	うつ	ウツ\<NL>"
          \. "wbx	うぃっ	ウィッ\<NL>"
          \. "wby	うぃく	ウィク\<NL>"
          \. "we	うぇ	ウェ\<NL>"
          \. "wi	うぃ	ウィ\<NL>"
          \. "wj	うぇん	ウェン\<NL>"
          \. "wk	うん	ウン\<NL>"
          \. "wo	を	ヲ\<NL>"
          \. "wp	うう	ウウ\<NL>"
          \. "wq	うぉん	ウォン\<NL>"
          \. "wv'	うぁう	ウァウ\<NL>"
          \. "wv,	うぉう	ウォウ\<NL>"
          \. "wv.	うぇい	ウェイ\<NL>"
          \. "wv;	うぁん	ウァン\<NL>"
          \. "wva	うぁ	ウァ\<NL>"
          \. "wve	うぇ	ウェ\<NL>"
          \. "wvi	うぃ	ウィ\<NL>"
          \. "wvj	うぇん	ウェン\<NL>"
          \. "wvk	うぅん	ウゥン\<NL>"
          \. "wvo	うぉ	ウォ\<NL>"
          \. "wvp	うぅう	ウゥウ\<NL>"
          \. "wvq	うぉん	ウォン\<NL>"
          \. "wvu	うぅ	ウゥ\<NL>"
          \. "wvx	うぃん	ウィン\<NL>"
          \. "wvy	うぅい	ウゥイ\<NL>"
          \. "wx	うぃん	ウィン\<NL>"
          \. "wy	うい	ウイ\<NL>"
          \. "wy	うい	ウイ\<NL>"
          \. "wz	うぉー	ウォー\<NL>"
          \. "x	いん	イン\<NL>"
          \. "z'	ざい	ザイ\<NL>"
          \. "z,	ぞう	ゾウ\<NL>"
          \. "z-	～\<NL>"
          \. "z.	ぜい	ゼイ\<NL>"
          \. "z/	・\<NL>"
          \. "z;	ざん	ザン\<NL>"
          \. "z[	『\<NL>"
          \. "z]	』\<NL>"
          \. "za	ざ	ザ\<NL>"
          \. "zb'	ざく	ザク\<NL>"
          \. "zb,	ぞく	ゾク\<NL>"
          \. "zb.	ぜき	ゼキ\<NL>"
          \. "zb;	ざっ	ザッ\<NL>"
          \. "zba	ざつ	ザツ\<NL>"
          \. "zbe	ぜつ	ゼツ\<NL>"
          \. "zbi	じつ	ジツ\<NL>"
          \. "zbj	ぜっ	ゼッ\<NL>"
          \. "zbk	ずっ	ズッ\<NL>"
          \. "zbo	ぞつ	ゾツ\<NL>"
          \. "zbp	ずく	ズク\<NL>"
          \. "zbq	ぞっ	ゾッ\<NL>"
          \. "zbu	ずつ	ズツ\<NL>"
          \. "zbx	じっ	ジッ\<NL>"
          \. "zby	じく	ジク\<NL>"
          \. "ze	ぜ	ゼ\<NL>"
          \. "zi	じ	ジ\<NL>"
          \. "zj	ぜん	ゼン\<NL>"
          \. "zk	ずん	ズン\<NL>"
          \. "zm'	じゃい	ジャイ\<NL>"
          \. "zm,	じょう	ジョウ\<NL>"
          \. "zm.	じぇい	ジェイ\<NL>"
          \. "zm;	じゃん	ジャン\<NL>"
          \. "zma	じゃ	ジャ\<NL>"
          \. "zme	じぇ	ジェ\<NL>"
          \. "zmi	じぃ	ジィ\<NL>"
          \. "zmj	じぇん	ジェン\<NL>"
          \. "zmk	じゅん	ジュン\<NL>"
          \. "zmm	じゅく	ジュク\<NL>"
          \. "zmo	じょ	ジョ\<NL>"
          \. "zmp	じゅう	ジュウ\<NL>"
          \. "zmq	じょん	ジョン\<NL>"
          \. "zmu	じゅ	ジュ\<NL>"
          \. "zmv	じょく	ジョク\<NL>"
          \. "zmw	じゅつ	ジュツ\<NL>"
          \. "zmx	じぃん	ジィン\<NL>"
          \. "zmy	じゅい	ジュイ\<NL>"
          \. "zmz	じゃく	ジャク\<NL>"
          \. "zo	ぞ	ゾ\<NL>"
          \. "zp	ずう	ズウ\<NL>"
          \. "zq	ぞん	ゾン\<NL>"
          \. "zu	ず	ズ\<NL>"
          \. "zw	じゅう	ジュウ\<NL>"
          \. "zx	じん	ジン\<NL>"
          \. "zy	ずい	ズイ\<NL>"
          \. "zz	じょう	ジョウ\<NL>"
  else
    let skk_rom_kana_rules = ""
          \. "a	あ	ア\<NL>"
          \. "bb	っ	ッ	b\<NL>"
          \. "ba	ば	バ\<NL>"
          \. "be	べ	ベ\<NL>"
          \. "bi	び	ビ\<NL>"
          \. "bo	ぼ	ボ\<NL>"
          \. "bu	ぶ	ブ\<NL>"
          \. "bya	びゃ	ビャ\<NL>"
          \. "bye	びぇ	ビェ\<NL>"
          \. "byi	びぃ	ビィ\<NL>"
          \. "byo	びょ	ビョ\<NL>"
          \. "byu	びゅ	ビュ\<NL>"
          \. "cc	っ	ッ	c\<NL>"
          \. "cha	ちゃ	チャ\<NL>"
          \. "che	ちぇ	チェ\<NL>"
          \. "chi	ち	チ\<NL>"
          \. "cho	ちょ	チョ\<NL>"
          \. "chu	ちゅ	チュ\<NL>"
          \. "cya	ちゃ	チャ\<NL>"
          \. "cye	ちぇ	チェ\<NL>"
          \. "cyi	ちぃ	チィ\<NL>"
          \. "cyo	ちょ	チョ\<NL>"
          \. "cyu	ちゅ	チュ\<NL>"
          \. "dd	っ	ッ	d\<NL>"
          \. "da	だ	ダ\<NL>"
          \. "de	で	デ\<NL>"
          \. "dha	でゃ	デャ\<NL>"
          \. "dhe	でぇ	デェ\<NL>"
          \. "dhi	でぃ	ディ\<NL>"
          \. "dho	でょ	デョ\<NL>"
          \. "dhu	でゅ	デュ\<NL>"
          \. "di	ぢ	ヂ\<NL>"
          \. "do	ど	ド\<NL>"
          \. "du	づ	ヅ\<NL>"
          \. "dya	ぢゃ	ヂャ\<NL>"
          \. "dye	ぢぇ	ヂェ\<NL>"
          \. "dyi	ぢぃ	ヂィ\<NL>"
          \. "dyo	ぢょ	ヂョ\<NL>"
          \. "dyu	ぢゅ	ヂュ\<NL>"
          \. "e	え	エ\<NL>"
          \. "ff	っ	ッ	f\<NL>"
          \. "fa	ふぁ	ファ\<NL>"
          \. "fe	ふぇ	フェ\<NL>"
          \. "fi	ふぃ	フィ\<NL>"
          \. "fo	ふぉ	フォ\<NL>"
          \. "fu	ふ	フ\<NL>"
          \. "fya	ふゃ	フャ\<NL>"
          \. "fye	ふぇ	フェ\<NL>"
          \. "fyi	ふぃ	フィ\<NL>"
          \. "fyo	ふょ	フョ\<NL>"
          \. "fyu	ふゅ	フュ\<NL>"
          \. "gg	っ	ッ	g\<NL>"
          \. "ga	が	ガ\<NL>"
          \. "ge	げ	ゲ\<NL>"
          \. "gi	ぎ	ギ\<NL>"
          \. "go	ご	ゴ\<NL>"
          \. "gu	ぐ	グ\<NL>"
          \. "gya	ぎゃ	ギャ\<NL>"
          \. "gye	ぎぇ	ギェ\<NL>"
          \. "gyi	ぎぃ	ギィ\<NL>"
          \. "gyo	ぎょ	ギョ\<NL>"
          \. "gyu	ぎゅ	ギュ\<NL>"
          \. "ha	は	ハ\<NL>"
          \. "he	へ	ヘ\<NL>"
          \. "hi	ひ	ヒ\<NL>"
          \. "ho	ほ	ホ\<NL>"
          \. "hu	ふ	フ\<NL>"
          \. "hya	ひゃ	ヒャ\<NL>"
          \. "hye	ひぇ	ヒェ\<NL>"
          \. "hyi	ひぃ	ヒィ\<NL>"
          \. "hyo	ひょ	ヒョ\<NL>"
          \. "hyu	ひゅ	ヒュ\<NL>"
          \. "i	い	イ\<NL>"
          \. "jj	っ	ッ	j\<NL>"
          \. "ja	じゃ	ジャ\<NL>"
          \. "je	じぇ	ジェ\<NL>"
          \. "ji	じ	ジ\<NL>"
          \. "jo	じょ	ジョ\<NL>"
          \. "ju	じゅ	ジュ\<NL>"
          \. "jya	じゃ	ジャ\<NL>"
          \. "jye	じぇ	ジェ\<NL>"
          \. "jyi	じぃ	ジィ\<NL>"
          \. "jyo	じょ	ジョ\<NL>"
          \. "jyu	じゅ	ジュ\<NL>"
          \. "kk	っ	ッ	k\<NL>"
          \. "ka	か	カ\<NL>"
          \. "ke	け	ケ\<NL>"
          \. "ki	き	キ\<NL>"
          \. "ko	こ	コ\<NL>"
          \. "ku	く	ク\<NL>"
          \. "kya	きゃ	キャ\<NL>"
          \. "kye	きぇ	キェ\<NL>"
          \. "kyi	きぃ	キィ\<NL>"
          \. "kyo	きょ	キョ\<NL>"
          \. "kyu	きゅ	キュ\<NL>"
          \. "ma	ま	マ\<NL>"
          \. "me	め	メ\<NL>"
          \. "mi	み	ミ\<NL>"
          \. "mo	も	モ\<NL>"
          \. "mu	む	ム\<NL>"
          \. "mya	みゃ	ミャ\<NL>"
          \. "mye	みぇ	ミェ\<NL>"
          \. "myi	みぃ	ミィ\<NL>"
          \. "myo	みょ	ミョ\<NL>"
          \. "myu	みゅ	ミュ\<NL>"
          \. "n	ん	ン\<NL>"
          \. "n'	ん	ン\<NL>"
          \. "na	な	ナ\<NL>"
          \. "ne	ね	ネ\<NL>"
          \. "ni	に	ニ\<NL>"
          \. "nn	ん	ン\<NL>"
          \. "no	の	ノ\<NL>"
          \. "nu	ぬ	ヌ\<NL>"
          \. "nya	にゃ	ニャ\<NL>"
          \. "nye	にぇ	ニェ\<NL>"
          \. "nyi	にぃ	ニィ\<NL>"
          \. "nyo	にょ	ニョ\<NL>"
          \. "nyu	にゅ	ニュ\<NL>"
          \. "o	お	オ\<NL>"
          \. "pp	っ	ッ	p\<NL>"
          \. "pa	ぱ	パ\<NL>"
          \. "pe	ぺ	ペ\<NL>"
          \. "pi	ぴ	ピ\<NL>"
          \. "po	ぽ	ポ\<NL>"
          \. "pu	ぷ	プ\<NL>"
          \. "pya	ぴゃ	ピャ\<NL>"
          \. "pye	ぴぇ	ピェ\<NL>"
          \. "pyi	ぴぃ	ピィ\<NL>"
          \. "pyo	ぴょ	ピョ\<NL>"
          \. "pyu	ぴゅ	ピュ\<NL>"
          \. "rr	っ	ッ	r\<NL>"
          \. "ra	ら	ラ\<NL>"
          \. "re	れ	レ\<NL>"
          \. "ri	り	リ\<NL>"
          \. "ro	ろ	ロ\<NL>"
          \. "ru	る	ル\<NL>"
          \. "rya	りゃ	リャ\<NL>"
          \. "rye	りぇ	リェ\<NL>"
          \. "ryi	りぃ	リィ\<NL>"
          \. "ryo	りょ	リョ\<NL>"
          \. "ryu	りゅ	リュ\<NL>"
          \. "ss	っ	ッ	s\<NL>"
          \. "sa	さ	サ\<NL>"
          \. "se	せ	セ\<NL>"
          \. "sha	しゃ	シャ\<NL>"
          \. "she	しぇ	シェ\<NL>"
          \. "shi	し	シ\<NL>"
          \. "sho	しょ	ショ\<NL>"
          \. "shu	しゅ	シュ\<NL>"
          \. "si	し	シ\<NL>"
          \. "so	そ	ソ\<NL>"
          \. "su	す	ス\<NL>"
          \. "sya	しゃ	シャ\<NL>"
          \. "sye	しぇ	シェ\<NL>"
          \. "syi	しぃ	シィ\<NL>"
          \. "syo	しょ	ショ\<NL>"
          \. "syu	しゅ	シュ\<NL>"
          \. "tt	っ	ッ	t\<NL>"
          \. "ta	た	タ\<NL>"
          \. "te	て	テ\<NL>"
          \. "tha	てぁ	テァ\<NL>"
          \. "the	てぇ	テェ\<NL>"
          \. "thi	てぃ	ティ\<NL>"
          \. "tho	てょ	テョ\<NL>"
          \. "thu	てゅ	テュ\<NL>"
          \. "ti	ち	チ\<NL>"
          \. "to	と	ト\<NL>"
          \. "tsu	つ	ツ\<NL>"
          \. "tu	つ	ツ\<NL>"
          \. "tya	ちゃ	チャ\<NL>"
          \. "tye	ちぇ	チェ\<NL>"
          \. "tyi	ちぃ	チィ\<NL>"
          \. "tyo	ちょ	チョ\<NL>"
          \. "tyu	ちゅ	チュ\<NL>"
          \. "u	う	ウ\<NL>"
          \. "vv	っ	ッ	v\<NL>"
          \. "va	う゛ぁ	ヴァ\<NL>"
          \. "ve	う゛ぇ	ヴェ\<NL>"
          \. "vi	う゛ぃ	ヴィ\<NL>"
          \. "vo	う゛ぉ	ヴォ\<NL>"
          \. "vu	う゛	ヴ\<NL>"
          \. "ww	っ	ッ	w\<NL>"
          \. "wa	わ	ワ\<NL>"
          \. "we	うぇ	ウェ\<NL>"
          \. "wi	うぃ	ウィ\<NL>"
          \. "wo	を	ヲ\<NL>"
          \. "wu	う	ウ\<NL>"
          \. "xx	っ	ッ	x\<NL>"
          \. "xa	ぁ	ァ\<NL>"
          \. "xe	ぇ	ェ\<NL>"
          \. "xi	ぃ	ィ\<NL>"
          \. "xka	か	ヵ\<NL>"
          \. "xke	け	ヶ\<NL>"
          \. "xo	ぉ	ォ\<NL>"
          \. "xtsu	っ	ッ\<NL>"
          \. "xtu	っ	ッ\<NL>"
          \. "xu	ぅ	ゥ\<NL>"
          \. "xwa	ゎ	ヮ\<NL>"
          \. "xwe	ゑ	ヱ\<NL>"
          \. "xwi	ゐ	ヰ\<NL>"
          \. "xya	ゃ	ャ\<NL>"
          \. "xyo	ょ	ョ\<NL>"
          \. "xyu	ゅ	ュ\<NL>"
          \. "yy	っ	ッ	y\<NL>"
          \. "ya	や	ヤ\<NL>"
          \. "ye	いぇ	イェ\<NL>"
          \. "yo	よ	ヨ\<NL>"
          \. "yu	ゆ	ユ\<NL>"
          \. "zz	っ	ッ	z\<NL>"
          \. "z,	‥\<NL>"
          \. "z-	～\<NL>"
          \. "z.	…\<NL>"
          \. "z/	・\<NL>"
          \. "z[	『\<NL>"
          \. "z]	』\<NL>"
          \. "za	ざ	ザ\<NL>"
          \. "ze	ぜ	ゼ\<NL>"
          \. "zh	←\<NL>"
          \. "zi	じ	ジ\<NL>"
          \. "zj	↓\<NL>"
          \. "zk	↑\<NL>"
          \. "zl	→\<NL>"
          \. "zo	ぞ	ゾ\<NL>"
          \. "zu	ず	ズ\<NL>"
          \. "zya	じゃ	ジャ\<NL>"
          \. "zye	じぇ	ジェ\<NL>"
          \. "zyi	じぃ	ジィ\<NL>"
          \. "zyo	じょ	ジョ\<NL>"
          \. "zyu	じゅ	ジュ\<NL>"
          \. "-	ー\<NL>"
          \. ":	：\<NL>"
          \. ";	；\<NL>"
          \. "!	！\<NL>"
          \. "?	？\<NL>"
          \. "[	「\<NL>"
          \. "]	」\<NL>"
  endif
endif

if !exists("skk_rom_func_rules")
  if g:skk_enable_jlod_layout
    let skk_rom_func_rules = ""
          \. ".	SkkCurrentKuten(kana)\<NL>"
          \. ",	SkkCurrentTouten(kana)\<NL>"
          \. "p	SkkAsciiMode(kana)\<NL>"
          \. "P	SkkZeneiMode(kana)\<NL>"
          \. "y	SkkToggleKana(kana)\<NL>"
          \. "Y	SkkSetHenkanPoint1(kana)\<NL>"
          \. "/	SkkAbbrevMode(kana)\<NL>"
  else
    let skk_rom_func_rules = ""
          \. ".	SkkCurrentKuten(kana)\<NL>"
          \. ",	SkkCurrentTouten(kana)\<NL>"
          \. "l	SkkAsciiMode(kana)\<NL>"
          \. "L	SkkZeneiMode(kana)\<NL>"
          \. "q	SkkToggleKana(kana)\<NL>"
          \. "Q	SkkSetHenkanPoint1(kana)\<NL>"
          \. "/	SkkAbbrevMode(kana)\<NL>"
  endif
endif

if !exists("skk_zenei_rules")
  let skk_zenei_rules = ""
        \. " 　\<NL>"
        \. "!！\<NL>"
        \. "\"”\<NL>"
        \. "#＃\<NL>"
        \. "$＄\<NL>"
        \. "%％\<NL>"
        \. "&＆\<NL>"
        \. "'’\<NL>"
        \. "(（\<NL>"
        \. ")）\<NL>"
        \. "*＊\<NL>"
        \. "+＋\<NL>"
        \. ",，\<NL>"
        \. "-－\<NL>"
        \. ".．\<NL>"
        \. "/／\<NL>"
        \. "0０\<NL>"
        \. "1１\<NL>"
        \. "2２\<NL>"
        \. "3３\<NL>"
        \. "4４\<NL>"
        \. "5５\<NL>"
        \. "6６\<NL>"
        \. "7７\<NL>"
        \. "8８\<NL>"
        \. "9９\<NL>"
        \. ":：\<NL>"
        \. ";；\<NL>"
        \. "<＜\<NL>"
        \. "=＝\<NL>"
        \. ">＞\<NL>"
        \. "?？\<NL>"
        \. "@＠\<NL>"
        \. "AＡ\<NL>"
        \. "BＢ\<NL>"
        \. "CＣ\<NL>"
        \. "DＤ\<NL>"
        \. "EＥ\<NL>"
        \. "FＦ\<NL>"
        \. "GＧ\<NL>"
        \. "HＨ\<NL>"
        \. "IＩ\<NL>"
        \. "JＪ\<NL>"
        \. "KＫ\<NL>"
        \. "LＬ\<NL>"
        \. "MＭ\<NL>"
        \. "NＮ\<NL>"
        \. "OＯ\<NL>"
        \. "PＰ\<NL>"
        \. "QＱ\<NL>"
        \. "RＲ\<NL>"
        \. "SＳ\<NL>"
        \. "TＴ\<NL>"
        \. "UＵ\<NL>"
        \. "VＶ\<NL>"
        \. "WＷ\<NL>"
        \. "XＸ\<NL>"
        \. "YＹ\<NL>"
        \. "ZＺ\<NL>"
        \. "[［\<NL>"
        \. "\\￥\<NL>"
        \. "]］\<NL>"
        \. "^＾\<NL>"
        \. "_＿\<NL>"
        \. "`‘\<NL>"
        \. "aａ\<NL>"
        \. "bｂ\<NL>"
        \. "cｃ\<NL>"
        \. "dｄ\<NL>"
        \. "eｅ\<NL>"
        \. "fｆ\<NL>"
        \. "gｇ\<NL>"
        \. "hｈ\<NL>"
        \. "iｉ\<NL>"
        \. "jｊ\<NL>"
        \. "kｋ\<NL>"
        \. "lｌ\<NL>"
        \. "mｍ\<NL>"
        \. "nｎ\<NL>"
        \. "oｏ\<NL>"
        \. "pｐ\<NL>"
        \. "qｑ\<NL>"
        \. "rｒ\<NL>"
        \. "sｓ\<NL>"
        \. "tｔ\<NL>"
        \. "uｕ\<NL>"
        \. "vｖ\<NL>"
        \. "wｗ\<NL>"
        \. "xｘ\<NL>"
        \. "yｙ\<NL>"
        \. "zｚ\<NL>"
        \. "{｛\<NL>"
        \. "|｜\<NL>"
        \. "}｝\<NL>"
        \. "~～\<NL>"
endif

if !exists('skk_imdisable_state')
  let skk_imdisable_state = 1
endif

" アスキーモードを示す文字列
if !exists('g:skk_ascii_mode_string')
  let g:skk_ascii_mode_string = 'SKK:aA'
endif

" かなモードを示す文字列
if !exists('g:skk_hira_mode_string')
  let g:skk_hira_mode_string = 'SKK:あ'
endif

" カナモードを示す文字列
if !exists('g:skk_kata_mode_string')
  let g:skk_kata_mode_string = 'SKK:ア'
endif

" 全英モードを示す文字列
if !exists('g:skk_zenei_mode_string')
  let g:skk_zenei_mode_string = 'SKK:Ａ'
endif

" SKK abbrev モードを示す文字列
if !exists('g:skk_abbrev_mode_string')
  let g:skk_abbrev_mode_string = 'SKK:aあ'
endif

" カーソルに色付けする
if !exists('g:skk_use_color_cursor')
  let g:skk_use_color_cursor = 0
endif

" かなモードを示すカーソル色
if !exists('g:skk_cursor_hira_color')
  let g:skk_cursor_hira_color = ''
endif

" カナモードを示すカーソル色
if !exists('g:skk_cursor_kata_color')
  let g:skk_cursor_kata_color = ''
endif

" 全英モードを示すカーソル色
if !exists('g:skk_cursor_zenei_color')
  let g:skk_cursor_zenei_color = ''
endif

" アスキーモードを示すカーソル色
if !exists('g:skk_cursor_ascii_color')
  let g:skk_cursor_ascii_color = ''
endif

" SKK abbrev モードを示すカーソル色
if !exists('g:skk_cursor_abbrev_color')
  let g:skk_cursor_abbrev_color = ''
endif

" 入力されたら▽モードにするキー(sticky key)
if !exists('g:skk_sticky_key')
  let g:skk_sticky_key = ""
endif

" 明示的な確定動作を行うキー
" 入力された文字列と直接比較されるので \ が必要
if !exists('g:skk_kakutei_key')
  let g:skk_kakutei_key = "\<C-j>"
endif

if !exists('skk_remap_lang_mode')
  let skk_remap_lang_mode = 0
endif

if !exists('skk_enable_hook')
  let skk_enable_hook = ''
endif

if !exists('skk_jisyo_encoding')
  let skk_jisyo_encoding = 'guess'
endif

if !exists('skk_large_jisyo_encoding')
  let skk_large_jisyo_encoding = 'guess'
endif
" }}}

" script variables {{{

let s:skk_rule_compiled = 0	" ルールを解析済みか？
let s:skk_in_cmdline = 0	" コマンドライン入力中か？
let s:skk_jisyo_modified = 0	" ユーザ辞書を変更したか？
let s:skk_saved_ru = &ruler		" ruler を変更するため保存しておく。
let s:skk_saved_ruf = &rulerformat	" rulerformat を変更するため保存しておく。
" s:skk_hiragana と s:skk_katakana はひらがな<->カタカナ変換で使う。
let s:skk_hiragana = "ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをん"
let s:skk_katakana = "ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲン"
" コマンドラインでは削除が行われたときに
" s:skk_cmdline_str s:skk_cmdline_pos が let され、入力のたびに unlet される。
" 上記の変数が存在していれば s:SkkGetline() s:SkkCursorCol() がその値を返す。
let s:bs_save = &backspace
let s:thisfile = expand("<sfile>")	" for RULES section

" }}}

" Helper Functions {{{

" ValidVarChar
" 文字列を受け取り、変数に使える形にして返す。
" 変数に使えない文字は __文字コード__ の形で返す。
function! s:ValidVarChar(str)
  let result = ''
  let i = 0
  while a:str[i] != ''
    if a:str[i] =~ '\w'	" [0-9A-Za-z_]
      let result = result . a:str[i]
    else
      let result = result . "__" . char2nr(a:str[i]) . "__"
    endif
    let i = i + 1
  endwhile
  return result
endfunction

" IsInclude
" parent の子に ch が含まれているか?
function! s:IsInclude(parent, ch)
  return s:HasChild(a:parent) && a:ch != '' &&
        \stridx(s:skk_rules_{a:parent}_child, a:ch) != -1
endfunction

" DoInclude
" parent の子に ch を含める
function! s:DoInclude(parent, ch)
  if !s:HasChild(a:parent)
    let s:skk_rules_{a:parent}_child = a:ch
  elseif !s:IsInclude(a:parent, a:ch)
    let s:skk_rules_{a:parent}_child = s:skk_rules_{a:parent}_child . a:ch
  endif
endfunction

" HasChild
" parent に子があるか?
function! s:HasChild(parent)
  return exists("s:skk_rules_{a:parent}_child")
endfunction

" GetRest
" rom の残す文字を返す。なければ空文字。
function! s:GetRest(rom)
  if exists("s:skk_rules_{a:rom}_rest")
    return s:skk_rules_{a:rom}_rest
  else
    return ''
  endif
endfunction

" SkkDowncase
" JLOD: Shift を押してないつもりにする
" Not JLOD: 現時点ではただ小文字を返す
if g:skk_enable_jlod_layout
  function! s:SkkDowncase(ch)
    if a:ch == '"'
      return "'"
    elseif  a:ch == '<'
      return ","
    elseif  a:ch == '>'
      return "."
    elseif  a:ch == ':'
      return ";"
    else
      return tolower(a:ch)
    endif
  endfunction
else
  function! s:SkkDowncase(ch)
    return tolower(a:ch)
  endfunction
endif

" SkkGetKana
" モードによりひらがなかカタカナを返す。
function! s:SkkGetKana(elem)
  if b:skk_mode == 'hira'
    let result = matchstr(a:elem, '^[^\t]*')
  else
    let result = substitute(a:elem, '^[^\t]*\t\([^\t]\+\)\t\?', '\1', '')
    if strlen(result) == 0
      let result = matchstr(a:elem, '^[^\t]*')
    endif
  endif
  return result
endfunction

" SkkGetLine (低レベルファンクション： cmdline のことを知っている。)
function! s:SkkGetLine(lnum)
  if s:skk_in_cmdline == 0
    return getline(a:lnum)
  else
    if exists("s:skk_cmdline_str")
      return s:skk_cmdline_str
    else
      return getcmdline()
    endif
  endif
endfunction

" SkkCursorLine (低レベルファンクション： cmdline のことを知っている。)
function! s:SkkCursorLine()
  if s:skk_in_cmdline == 0
    return exists("s:skk_cur_line") ? s:skk_cur_line : line(".")
  else
    return 0
  endif
endfunction

" SkkCursorCol (低レベルファンクション： cmdline のことを知っている。)
function! s:SkkCursorCol()
  if s:skk_in_cmdline == 0
    return exists("s:skk_cur_col") ? s:skk_cur_col : col(".")
  else
    if exists("s:skk_cmdline_pos")
      return s:skk_cmdline_pos
    else
      return getcmdpos()
    endif
  endif
endfunction

" SkkWait sec秒間待つ。何か入力があれば、その文字を返す。
function! s:SkkWait(sec)
  let i = a:sec * 10
  while i > 0
    let ch = getchar(0)
    if ch != 0
      return nr2char(ch)
    endif
    sleep 100m
    let i = i - 1
  endwhile
  return ""
endfunction

" msg に対して yes なら 1 を no なら 0 を返す。
function! s:SkkYesNo(msg)
  let text = ""
  let prompt = a:msg . "(yes or no) "
  let ims_save = &imsearch
  let arg = maparg("\<C-g>", "c")
  try
    cnoremap <buffer> <C-g> <C-\>e'no'<CR><CR>
    let &imsearch = 0
    while 1
      let str = input(prompt, text)
      if str == "yes"
        return 1
      elseif str == "no"
        return 0
      else
        echon "\rPlease answer yes or no."
        let text = s:SkkWait(1)
      endif
    endwhile
  catch /^Vim:Interrupt$/
    return 0
  finally
    let &imsearch = ims_save
    if arg == ""
      silent! cunmap <buffer> <C-g>
    else
      silent exe "cnoremap <buffer> <C-g> " . arg
    endif
    echon "\n"
  endtry
endfunction

function! s:SkkEcho(msg, highlight, wait)
  exe "echohl " . a:highlight
  echo a:msg
  echohl None
  return a:wait ? s:SkkWait(a:wait) : ""
endfunction

" // で区切られたs1とs2の和集合を返す。
function! s:SkkMerge(s1, s2)
  if a:s1 == ""
    return a:s2
  elseif a:s2 == ""
    return a:s1
  endif
  let result = a:s1
  let start = stridx(a:s2, '/')
  let pos = matchend(a:s2, '/[^/]\+/')
  while pos != -1
    let elem = strpart(a:s2, start + 1, pos - start - 1)
    if stridx(result, '/' . elem) == -1
      let result = result . elem
    endif
    let start = pos - 1
    let pos = matchend(a:s2, '/[^/]\+/', start)
  endwhile
  return result
endfunction

" s1に含まれ、s2に含まれていない要素の集合を返す。
function! s:SkkPurge(s1, s2)
  if a:s2 == ""
    return a:s1
  elseif a:s1 == ""
    return ""
  endif
  let result = ""
  let start = stridx(a:s1, '/')
  let pos = matchend(a:s1, '/[^/]\+\ze/')
  while pos != -1
    let elem = strpart(a:s1, start, pos - start)
    if stridx(a:s2, elem . '/') == -1
      let result = result . elem
    endif
    let start = pos
    let pos = matchend(a:s1, '/[^/]\+\ze/', start)
  endwhile
  return result == "" ? result : result . '/'
endfunction

" b:skk_mode, b:skk_abbrev_mode_on に合わせて、カーソルの色を変更する
function! s:SkkSetCursorColor()
  if has('gui_running') && g:skk_use_color_cursor
    if b:skk_abbrev_mode_on
      " royalblue:#4169e1
      let color = (&background == 'light' ? '#4169e1' : '#4169e1')
      if g:skk_cursor_abbrev_color != ''
        let color = g:skk_cursor_abbrev_color
      endif
    elseif b:skk_mode == 'hira'
      " coral4:#8b3e2f, pink:#ffc0cb
      let color = (&background == 'light' ? '#8b3e2f' : '#ffc0cb')
      if g:skk_cursor_hira_color != ''
        let color = g:skk_cursor_hira_color
      endif
    elseif b:skk_mode == 'kata'
      " forestgreen:#228b22, green:#00ff00
      let color = (&background == 'light' ? '#228b22' : '#00ff00')
      if g:skk_cursor_kata_color != ''
        let color = g:skk_cursor_kata_color
      endif
    elseif b:skk_mode == 'zenei'
      " gold:#ffd700
      let color = (&background == 'light' ? '#ffd700' : '#ffd700')
      if g:skk_cursor_zenei_color != ''
        let color = g:skk_cursor_zenei_color
      endif
    elseif b:skk_mode == 'ascii'
      " ivory4:#8b8b83, gray:#bebebe
      let color = (&background == 'light' ? '#8b8b83' : '#bebebe')
      if g:skk_cursor_ascii_color != ''
        let color = g:skk_cursor_ascii_color
      endif
    endif
    execute 'highlight lCursor guibg=' . color
  endif
endfunction
" }}}

" Initialization {{{

" SkkBufInit
" バッファ変数を初期化する
function! s:SkkBufInit()
  let b:skk_on = 0		" 0=off 1=on
  let b:skk_mode = g:skk_initial_mode	" hira|kata|zenei|ascii
  let b:skk_line = 0		" 現在の行 (hira|kata だけで使う)
  let b:skk_rom = ""		" 入力途中のローマ字 (hira|kata だけで使う)
  let b:skk_romv = ""		" 入力途中のローマ字 変数名
  let b:skk_rstart = 0		" ローマ字のスタート桁 (hira|kata だけで使う)
  let b:skk_henkan_mode = 0
  " 0=■モード 1=▽モード 2=▽モード (送りがな入力中) 3=▼モード
  " 4=選択方式で確定したとき
  let b:skk_abbrev_mode_on = 0	" abbrev モードか？
  if g:skk_imdisable_state == 0 || g:skk_imdisable_state == 1
    let &imdisable = g:skk_imdisable_state
  endif
  if !exists("b:skk_fo_save")
    let b:skk_fo_save = &formatoptions
  endif
  let b:skk_autofill = 0	" Auto Fill モードか？
  if !exists("b:skk_map_silent")
    let b:skk_map_silent = 2	" <silent> 付きでマップしたか？
  endif
  call s:SkkSetCursorColor() " カーソル色の設定
endfunction

" SkkRuleCompile
" skk_rom_kana_rules を解析して木構造らしきものにする。
" 例えば ba	ば	バ\<NL> という行があったとすると
" skk_rules_b_child = "a"
" skk_rules_ba = "ば	バ"
" というように変数を作っていく。
" skk_rules_b_child というのは `b' の後につながるアルファベットで
" ba bi bu be bo bya ... というローマ字があれば "aiueoy" となる。
" skk_rules_ba というのは
" `ba' が入力されたら確定する要素があるということを示す。
" skk_rules_dd_rest というのは `dd' という入力があったときに
" `っ' という確定要素の他に残す文字列。
function! SkkRuleCompile()
  " ローマ字→かなの処理
  if exists("g:skk_rom_kana_rules")
    let ptr = g:skk_rom_kana_rules
    if exists("g:skk_user_rom_kana_rules")
      let ptr = ptr . g:skk_user_rom_kana_rules
    endif
    while ptr != ""
      let line = matchstr(ptr, "^[^\<NL>]*")
      let ptr = strpart(ptr, strlen(line) + 1)
      let rom = matchstr(line, '^[^\t]\+')
      let kana = matchstr(line, '[^\t]\+\t\?[^\t]*\t\?', strlen(rom))
      if strlen(kana) == 0
        continue
      endif
      let line = strpart(line, strlen(rom) + strlen(kana) + 1)
      let idx = 0
      let romvar = ""
      while rom[idx] != ""
        let ch = rom[idx]
        if strlen(romvar) != 0
          call s:DoInclude(romvar, ch)
        endif
        let romvar = romvar . s:ValidVarChar(ch)
        let idx = idx + 1
      endwhile
      let s:skk_rules_{romvar} = kana
      if strlen(line) != 0
        let s:skk_rules_{romvar}_rest = line
      endif
    endwhile
    unlet g:skk_rom_kana_rules
  endif
  " ローマ字→関数の処理
  if exists("g:skk_rom_func_rules")
    let ptr = g:skk_rom_func_rules
    if exists("g:skk_user_rom_func_rules")
      let ptr = ptr . g:skk_user_rom_func_rules
    endif
    while ptr != ""
      let line = matchstr(ptr, "^[^\<NL>]*")
      let ptr = strpart(ptr, strlen(line) + 1)
      let rom = matchstr(line, '^[^\t]\+')
      let func = strpart(line, strlen(rom) + 1)
      if strlen(rom) == 0 || strlen(func) == 0
        continue
      endif
      let idx = 0
      let romvar = ""
      while rom[idx] != ""
        let ch = rom[idx]
        if strlen(romvar) != 0
          call s:DoInclude(romvar, ch)
        endif
        let romvar = romvar . s:ValidVarChar(ch)
        let idx = idx + 1
      endwhile
      let s:skk_rules_{romvar}_func = func
    endwhile
    unlet g:skk_rom_func_rules
  endif
  " アルファベット→全角英数の処理
  if exists("g:skk_zenei_rules")
    let ptr = g:skk_zenei_rules
    if exists("g:skk_user_zenei_rules")
      let ptr = ptr . g:skk_user_zenei_rules
    endif
    while ptr != ''
      let line = matchstr(ptr, "[^\<NL>]*")
      let ptr = strpart(ptr, strlen(line) + 1)
      let han = char2nr(line[0])
      let zen = matchstr(line, ".*", 1)
      if han >= 0x80 || strlen(zen) == 0
        continue
      endif
      let s:skk_zenei_rules_{han} = zen
    endwhile
    unlet g:skk_zenei_rules
  endif
  let s:skk_rule_compiled = 1
endfunction

" global mapping
inoremap <silent> <Plug>(skk-toggle-im) <C-r>=SkkToggle()<CR>
cnoremap          <Plug>(skk-toggle-im) <C-r>=SkkToggle()<CR>

inoremap <silent> <Plug>(skk-enable-im) <C-r>=SkkEnable()<CR>
cnoremap          <Plug>(skk-enable-im) <C-r>=SkkEnable()<CR>

inoremap <silent> <Plug>(skk-disable-im) <C-r>=SkkDisable()<CR>
cnoremap          <Plug>(skk-disable-im) <C-r>=SkkDisable()<CR>

if g:skk_control_j_key != ""
  exe "imap" g:skk_control_j_key "<Plug>(skk-toggle-im)"
  exe "cmap" g:skk_control_j_key "<Plug>(skk-toggle-im)"
endif

nnoremap <silent> <Plug>(skk-save-jisyo)    :call <SID>SkkSaveJisyo(1, 0)<CR>
if g:skk_manual_save_jisyo_keys != ""
  exe "nmap" g:skk_manual_save_jisyo_keys "<Plug>(skk-save-jisyo)"
endif

" 終了時に辞書の保存
function! SkkSetAutoSaveJisyo(nr)
  augroup skk
    autocmd!
    if a:nr == 0
      autocmd VimLeavePre * call <SID>SkkSaveJisyo(1, 0)
    elseif a:nr > 0
      autocmd VimLeavePre * call <SID>SkkSaveJisyo(0, 0)
    endif
  augroup END
  let g:skk_auto_save_jisyo = a:nr
endfunction

call SkkSetAutoSaveJisyo(g:skk_auto_save_jisyo)

" 暇なときに時間のかかることをやってしまう。
augroup skk-setup
  autocmd!
  autocmd CursorHold * call s:SkkSetup()
augroup END

function! s:SkkSetup()
  augroup skk-setup
    autocmd!
  augroup END
  augroup! skk-setup
  if s:skk_rule_compiled == 0
    call SkkRuleCompile()
  endif
endfunction
" }}}

" Mode Change {{{

function! s:SkkOn()
  let b:skk_on = 1
  let &rulerformat = "%31(%-14{SkkGetModeStr()}%l,%c%V%=%P%)"
  let &ruler = 1
endfunction

function! SkkEnable()
  if !exists("b:skk_on")
    call s:SkkBufInit()
  endif
  if b:skk_on
    return ''
  endif

  let s:skk_in_cmdline = mode() == "c"
  if s:skk_rule_compiled == 0
    call SkkRuleCompile()
  endif
  call s:SkkOn()
  set cpo-=v
  set cpo-=<
  call SkkMap(s:skk_in_cmdline == 0)
  call s:SkkMapCR()

  " Call each function separated by ','.
  let hook = g:skk_enable_hook
  while hook != ''
    let comma_pos = stridx(hook, ',')
    if comma_pos !=# -1
      let fn = strpart(hook, 0, comma_pos)
      let hook = strpart(hook, strlen(fn) + 1)
    else
      let fn = hook
      let hook = ''
    endif

    if exists('*' . fn)    " XXX `exists('*' . fn)` is supported by old Vim?
      call {fn}()
    endif
  endwhile

  let &l:formatoptions = ""
  if s:skk_in_cmdline && v:version >= 603
    redrawstatus
  endif
  return "\<C-^>"
endfunction

function! SkkDisable()
  if !exists("b:skk_on")
    call s:SkkBufInit()
  endif
  if !b:skk_on
    return ''
  endif

  let s:skk_in_cmdline = mode() == "c"
  let kana = s:SkkKakutei()
  if !g:skk_keep_state
    call s:SkkBufInit()
  endif
  if s:skk_in_cmdline == 0
    call s:SkkUnmapNormal()
  endif
  call SkkMap(0)
  let b:skk_on = 0
  let &rulerformat = s:skk_saved_ruf
  let &ruler = s:skk_saved_ru
  let &backspace = s:bs_save
  let &l:formatoptions = b:skk_fo_save
  return kana . "\<C-^>"
endfunction

function! SkkToggle()
  if !exists("b:skk_on")
    call s:SkkBufInit()
  endif

  if b:skk_on
    return SkkDisable()
  else
    return SkkEnable()
  endif
endfunction

function! SkkIsEnabled()
  return exists('b:skk_on') && b:skk_on
endfunction

" SkkToggleKana
" ■モード・▼モード時にはひらがな入力モード・カタカナ入力モードを切り替える。
" ▽モード時には b:skk_hstart からカーソルの間をひらがな入力モードのときには
" カタカナに、カタカナ入力モードのときにはひらがなに変換する。
function! SkkToggleKana(kana)
  if b:skk_henkan_mode == 1 || b:skk_henkan_mode == 2
    let kana = a:kana . s:SkkCleanRom()
    let ostart = b:skk_henkan_mode == 2 ? b:skk_ostart : s:SkkCursorCol()
    let hstart = b:skk_hstart + strlen(g:skk_marker_white) - 1
    let kana = strpart(s:SkkGetLine("."), hstart, ostart - 1 - hstart) . kana
    call s:SkkEraseYomi()
    let b:skk_henkan_mode = 0
    return b:skk_mode == 'hira' ? s:SkkHira2Kata(kana) : s:SkkKata2Hira(kana)
  else
    return b:skk_mode == 'hira' ? SkkKataMode(a:kana) : SkkHiraMode(a:kana)
  endif
endfunction

function! SkkAbbrev2Zenei()
  if b:skk_abbrev_mode_on == 0
    return ""
  endif
  let hstart = b:skk_hstart + strlen(g:skk_marker_white) - 1
  let str = strpart(s:SkkGetLine("."), hstart, s:SkkCursorCol() - 1 - hstart)
  call s:SkkCleanRom()
  call s:SkkEraseYomi()
  let b:skk_henkan_mode = 0
  let b:skk_abbrev_mode_on = 0
  return s:SkkAscii2Zenei(str)
endfunction

" SkkHiraMode
" ひらがな入力モードにする。
function! SkkHiraMode(kana)
  let kana = a:kana . s:SkkKakutei()
  let b:skk_mode = 'hira'
  call s:SkkSetCursorColor()
  return kana
endfunction

" SkkKataMode
" カタカナ入力モードにする。
function! SkkKataMode(kana)
  let kana = a:kana . s:SkkKakutei()
  let b:skk_mode = 'kata'
  call s:SkkSetCursorColor()
  return kana
endfunction

" SkkZeneiMode
" 全角英数入力モードにする。
function! SkkZeneiMode(kana)
  let kana = a:kana . s:SkkKakutei()
  let b:skk_mode = 'zenei'
  call s:SkkSetCursorColor()
  return kana
endfunction

" SkkAsciiMode
" ASCII直接入力モードにする。
function! SkkAsciiMode(kana)
  let kana = a:kana . s:SkkKakutei()
  let b:skk_mode = 'ascii'
  call s:SkkSetCursorColor()
  return kana
endfunction

function! SkkAbbrevMode(kana)
  if b:skk_henkan_mode == 1 || b:skk_henkan_mode == 2
    call s:SkkEcho("Already in ▽ mode", "WarningMsg", 1)
    return ""
  endif
  let kana = SkkSetHenkanPoint1(a:kana)
  let b:skk_abbrev_mode_on = 1
  call s:SkkSetCursorColor()
  return kana
endfunction

" rulerformat で表示する現在のモード
function! SkkGetModeStr()
  let m = stridx("iRc", mode())		" 0..1=Insert 2=cmdline
  if !exists("b:skk_on") "|| b:skk_on == 0
    let str = " "	" 空文字だと幅がずれる。
  elseif m == -1
    let str = " "
  elseif m < 2 && &iminsert == 0
    let str = " "
  elseif m == 2 && s:skk_in_cmdline == 0
    let str = " "
  elseif b:skk_abbrev_mode_on == 1
    let str = "[" . g:skk_abbrev_mode_string . "]"
  elseif b:skk_mode == "hira"
    let str = "[" . g:skk_hira_mode_string . "]"
  elseif b:skk_mode == "kata"
    let str = "[" . g:skk_kata_mode_string . "]"
  elseif b:skk_mode == "zenei"
    let str = "[" . g:skk_zenei_mode_string . "]"
  else
    let str = "[" . g:skk_ascii_mode_string . "]"
  endif
  if exists("b:skk_autofill") && b:skk_autofill && str != " "
    let str = str . "FILL"
  endif
  return str
endfunction
" }}}

" Erase {{{

" n個の <C-h> を返す。
function! s:SkkMakeBS(n)
  let i = 0
  let bs = ""
  while i < a:n
    let bs = bs . "\<C-h>"
    let i = i + 1
  endwhile
  return bs
endfunction

" <C-h> で組み立てられるか？ 削除ポイントがカーソル位置より前なら可。
function! s:SkkCanBS(dell, delc, curl, curc)
  if a:dell == a:curl
    return a:delc <= a:curc
  else
    return a:dell < a:curl
  endif
endfunction

" SkkDeleteRange line行の start から end までを削除する。
" (低レベルファンクション： cmdline のことを知っている。)
function! s:SkkDeleteRange(line, start, end)
  if a:start >= a:end
    return
  endif
  if s:skk_in_cmdline == 0
    let lnum = s:SkkCursorLine()
    let cnum = s:SkkCursorCol()
    if s:SkkCanBS(a:line, a:start, lnum, cnum)
      if lnum == a:line
        let s = strpart(getline(a:line), a:start - 1, cnum - a:start)
        let s:skk_cur_col = cnum + a:start - a:end
      else
        let s = strpart(getline(a:line), a:start - 1) . "\n"
        let i = a:line + 1
        while i < lnum
          let s = s . getline(i) . "\n"
          let i = i + 1
        endwhile
        let s = s . strpart(getline(lnum), 0, cnum - 1)
        if indent(lnum) > 0 && &paste == 0
          set paste
          let s:skk_pasted = 1
        endif
        set backspace=start,indent,eol
      endif
      let bs = s:SkkMakeBS(strlen(substitute(s, ".", "x", "g")))
      let bs = bs . strpart(s, a:end - a:start)
      let s:skk_bs_str = exists("s:skk_bs_str") ? s:skk_bs_str . bs : bs
    else
      let str = strpart(getline(a:line), a:start - 1, a:end - a:start)
      let len = strlen(substitute(str, ".", "x", "g"))
      if len > 0
        if lnum == a:line && cnum > a:start
          let cnum = cnum + a:start - a:end
        endif
        call cursor(a:line, a:start)
        exe "normal! " . len . "\"_x"
        call cursor(lnum, cnum)
      endif
    endif
  else
    let str = s:SkkGetLine(0)
    let str = strpart(str, 0, a:start - 1) . strpart(str, a:end - 1)
    let s:skk_cmdline_str = str
    let s:skk_cmdline_pos = s:SkkCursorCol() - a:end + a:start
  endif
endfunction

" SkkEraseRom
" ローマ字を削除する。
function! s:SkkEraseRom()
  if b:skk_rom_erased
    return
  endif
  let b:skk_rom_erased = 1
  let len = strlen(b:skk_rom)
  let c = s:SkkCursorCol()
  call s:SkkDeleteRange(s:SkkCursorLine(), c - len, c)
endfunction

" SkkCleanRom
" 確定できるものがあればそれを返して skk_rom を空にする。
function! s:SkkCleanRom()
  let kana = ''
  if b:skk_rom != ''
    if exists("s:skk_rules_{b:skk_romv}")
      let kana = s:SkkGetKana(s:skk_rules_{b:skk_romv})
    endif
    call s:SkkEraseRom()
    let b:skk_rom = ''
    let b:skk_romv = ''
  endif
  let b:skk_rstart = 0
  unlet! b:skk_comp_key
  return kana
endfunction

" SkkEraseYomi
" skk_hstart からカーソル位置まで削除する。
function! s:SkkEraseYomi()
  let lnum = s:SkkCursorLine()
  if b:skk_line == lnum
    call s:SkkDeleteRange(lnum, b:skk_hstart, s:SkkCursorCol())
  else
    call s:SkkEraseYomi2(b:skk_line, b:skk_hstart, lnum, s:SkkCursorCol())
  endif
endfunction

" SkkEraseYomi2 複数行バージョン
function! s:SkkEraseYomi2(lstart, start, lend, end)
  let str = strpart(getline(a:lstart), a:start - 1) . "\n"
  let i = a:lstart + 1
  while i < a:lend
    let str = str . getline(i) . "\n"
    let i = i + 1
  endwhile
  let str = str . strpart(getline(a:lend), 0, a:end - 1)
  let len = strlen(substitute(str, ".", "x", "g"))
  if len > 0
    let bs = s:SkkMakeBS(len)
    let s:skk_bs_str = exists("s:skk_bs_str") ? s:skk_bs_str . bs : bs
    let s:skk_cur_col = a:start + 1
    let s:skk_cur_line = a:lstart
    set backspace=indent,eol
  endif
endfunction
" }}}

" mapping functions {{{

" SkkControlJ
" lmap の中から呼ばれる。skk を on にすることはない。
" b:skk_mode == 'hira'|'kata' && 未確定要素がある -> 確定
" b:skk_mode == 'hira'|'kata' && 未確定要素がない -> b:skk_on = 0
" b:skk_mode == 'zenei'|'ascii' -> b:skk_mode = 'hira'
function! s:SkkControlJ()
  if b:skk_mode =~ 'hira\|kata'
    if b:skk_henkan_mode != 0
      return s:SkkKakutei()
    else
      return SkkDisable()
    endif
  else		" zenei|ascii
    return SkkHiraMode("")
  endif
endfunction

" SkkBackspace
" ▽モードで▽より前なら確定する。
" ▼モードなら確定して直前の文字を削除する。
" ローマ字入力中なら直前のローマ字を消す。
" 入力途中のローマ字がなければ前のかなを消す。
function! s:SkkBackspace()
  if b:skk_mode =~ 'hira\|kata'
    if strlen(b:skk_rom) > 0
      let b:skk_rom = strpart(b:skk_rom, 0, strlen(b:skk_rom) - 1)
      let b:skk_romv = s:ValidVarChar(b:skk_rom)
    elseif b:skk_henkan_mode == 1 && s:SkkCursorCol() <= b:skk_hstart + strlen(g:skk_marker_white)
      call s:SkkKakutei()
      return ''
    elseif b:skk_henkan_mode == 3
      call s:SkkKakutei()
    else
      let b:skk_rstart = 0
    endif
  endif
  unlet! b:skk_comp_key
  return "\<C-h>"
endfunction

" SkkCancell
function! s:SkkCancel()
  if b:skk_henkan_mode == 1 && s:SkkInCompletion()
    let key = b:skk_comp_key
    unlet b:skk_comp_key
    call s:SkkEraseYomi()
    return g:skk_marker_white . key
  endif
  call s:SkkCleanRom()	" 戻り値は捨てる。
  if b:skk_henkan_mode == 0
  elseif b:skk_henkan_mode == 1 || b:skk_henkan_mode == 2
    call s:SkkEraseYomi()
    let b:skk_henkan_mode = 0
    let b:skk_abbrev_mode_on = 0
  elseif b:skk_henkan_mode >= 3
    call s:SkkFaceOff()
    call s:SkkEraseYomi()
    let b:skk_ostart = 0
    let b:skk_henkan_mode = 1
    return g:skk_marker_white . b:skk_midasi . b:skk_okurigana
  endif
  return ''
endfunction

function! SkkMap(silent)
  if hasmapto("<SID>SkkKey", "l") && b:skk_map_silent == a:silent
    return
  endif
  let b:skk_map_silent = a:silent
  let mapstr = (g:skk_remap_lang_mode ? 'lmap' : 'lnoremap') . ' <buffer>'
  if b:skk_map_silent
    let mapstr = mapstr . '<silent>'
  endif
  let mapstr = mapstr . ' '
  lmapclear <buffer>
  let i = char2nr(" ")
  let tilde = char2nr("~")
  while i <= tilde
    let ch = "<Char-" . i . ">"
    exe mapstr . ch . " <C-r>=<SID>SkkKey(\"" . escape(nr2char(i), '"\|') . "\")<CR>"
    let i = i + 1
  endwhile
  exe mapstr . '<Tab>	<C-r>=<SID>SkkKey("<C-v><Tab>")<CR>'
  exe mapstr . '<CR>	<C-r>=<SID>SkkKey("<C-v><CR>")<CR><CR>'
  exe mapstr . '<C-j>	<C-r>=<SID>SkkKey("<C-v><C-j>")<CR>'
  exe mapstr . '<C-g>	<C-r>=<SID>SkkKey("<C-v><C-g>")<CR>'
  exe mapstr . '<BS>	<C-r>=<SID>SkkKey("<C-v><C-h>")<CR>'
  exe mapstr . '<C-h>	<C-r>=<SID>SkkKey("<C-v><C-h>")<CR>'
  exe mapstr . '<Home>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Home>'
  exe mapstr . '<End>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><End>'
  exe mapstr . '<Left>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Left>'
  exe mapstr . '<Right>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Right>'
  exe mapstr . '<C-a>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Home>'
  exe mapstr . '<C-e>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><End>'
  exe mapstr . '<C-b>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Left>'
  exe mapstr . '<C-f>	<C-r>=<SID>SkkKey("<C-v><C-a>")<CR><Right>'
  exe mapstr . '<C-w>	<C-r>=<SID>SkkKey("<C-v><C-u>")<CR><C-w>'
  exe mapstr . '<C-u>	<C-r>=<SID>SkkKey("<C-v><C-u>")<CR><C-u>'
  if mode() !=# 'c'
    exe mapstr . '<Esc>	<C-r>=<SID>SkkKey("<C-v><Esc>")<CR><Esc>'
    exe mapstr . '<C-c>	<C-r>=<SID>SkkKey("<C-v><Esc>")<CR><C-c>'
  endif
  exe mapstr . g:skk_abbrev_to_zenei_key . " <C-r>=<SID>SkkKey(\"<C-v><C-q>\")<CR>"
  if exists("g:format_command") && g:skk_autofill_toggle_key != ""
    exe mapstr . g:skk_autofill_toggle_key . " <C-r>=<SID>SkkKey(\"<C-v><C-k>\")<CR>"
  endif
endfunction

function! s:SkkMapCR()
  let mapstr = g:skk_remap_lang_mode ? 'lmap' : 'lnoremap'
  if g:skk_egg_like_newline && b:skk_henkan_mode != 0
    exe mapstr '<buffer> <CR> <C-r>=<SID>SkkKey("<C-v><CR>")<CR>'
  else
    exe mapstr '<buffer> <CR> <C-r>=<SID>SkkKey("<C-v><CR>")<CR><CR>'
  endif
endfunction

" f や r などがあるため必要
function! s:SkkMapNormal()
  let keys = "iIaAoOcCsSR"
  let i = 0
  while keys[i] != ""
    if v:version < 700
      exe "nnoremap <silent> <buffer> " . keys[i] . " :<C-u>call SkkMap(1)<CR>:let &iminsert = 1<CR>" . keys[i]
    else
      exe "nnoremap <silent> <buffer> <expr> " . keys[i] . ' <SID>SkkDoNormal(' . string(keys[i]) . ')'
    endif
    let i = i + 1
  endwhile
  call SkkMap(0)	" コマンドライン側にセットしておく。
endfunction

function! s:SkkDoNormal(key)
  call SkkMap(1)
  let &iminsert = 1
  return a:key
endfunction

function! s:SkkUnmapNormal()
  let keys = "iIaAoOcCsSR"
  let i = 0
  while keys[i] != ""
    silent! exe "nunmap <buffer> " . keys[i]
    let i = i + 1
  endwhile
endfunction

function! s:SkkKey(key)
  let s:skk_in_cmdline = mode() == "c"
  unlet! s:skk_cmdline_str s:skk_cmdline_pos s:skk_bs_str s:skk_cur_col s:skk_cur_line
  let &l:formatoptions = ""
  let b:skk_rom_erased = 0
  if b:skk_on == 0
    call s:SkkOn()
  endif
  if b:skk_map_silent == s:skk_in_cmdline
    call SkkMap(s:skk_in_cmdline == 0)
  endif
  if a:key == "\<CR>"
    if s:skk_in_cmdline && !g:skk_keep_state && (!g:skk_egg_like_newline || b:skk_henkan_mode == 0)
      if &imsearch == 1
        let &imsearch = 0
      endif
      let &iminsert = 0
    endif
    let str = s:SkkKakutei()
    let &l:formatoptions = b:skk_fo_save
  elseif a:key == "\<Esc>"
    if g:skk_keep_state
      let str = s:SkkKakutei()
      if s:skk_in_cmdline == 0
        call s:SkkMapNormal()
        let &iminsert = 0
      endif
    else
      let str = SkkDisable()
    endif
    let &backspace = s:bs_save
    let &l:formatoptions = b:skk_fo_save
  elseif a:key == "\<C-j>"
    let str = s:SkkControlJ()
  elseif a:key == "\<C-g>"
    let str = s:SkkCancel()
  elseif a:key == "\<C-h>"
    let str = s:SkkBackspace()
    if s:skk_in_cmdline && !g:skk_keep_state && getcmdpos() == 1 && strlen(getcmdline()) == 0
      if &imsearch == 1
        let &imsearch = 0
      endif
      let &iminsert = 0
    endif
    let &backspace = s:bs_save
  elseif a:key == "\<C-a>"
    let str = s:SkkCleanRom()
  elseif a:key == "\<C-u>"
    let str = s:SkkCleanRom()
    let &backspace = s:bs_save
  elseif a:key == "\<C-q>"
    let str = SkkAbbrev2Zenei()
  elseif a:key == "\<C-k>"
    let b:skk_autofill = b:skk_autofill ? 0 : 1
    let str = ""
  else
    if b:skk_autofill && s:skk_in_cmdline == 0 && b:skk_henkan_mode == 0 && b:skk_rom == ""
      call s:SkkDoAutoFill()
    endif
    let str = s:SkkInsert(a:key)
  endif
  call s:SkkMapCR()
  if exists("s:skk_pasted")
    let str = str . "\<C-o>:set nopaste\<CR>"
    unlet s:skk_pasted
  endif
  return s:skk_in_cmdline ? s:SkkMakeCmdStr(str) : exists("s:skk_bs_str") ? s:skk_bs_str . str : str
endfunction

" }}}

" Insert functions {{{

" 入力の大元。ここで状態、キーを見てそれぞれの関数を呼び出す。
function! s:SkkInsert(char)
  if b:skk_mode == 'ascii'
    return a:char
  elseif b:skk_mode == 'zenei'
    return s:SkkInsertZenei(a:char)
  else		" hira|kata
    try
      if b:skk_henkan_mode != 0 && a:char == g:skk_kakutei_key
        call s:SkkKakutei()
        return ''
      elseif b:skk_henkan_mode == 3
        return SkkHenkan(a:char)
      elseif b:skk_henkan_mode == 0 && a:char == g:skk_sticky_key
        return SkkSetHenkanPoint('')
      elseif b:skk_henkan_mode == 1 && a:char == g:skk_sticky_key
        if !s:SkkCheckMarker(g:skk_marker_white, b:skk_hstart)
          let b:skk_henkan_mode = 0
          throw "skk cannot find " . g:skk_marker_white . " mark"
        endif
        " g:skk_sticky_key 連続押下で g:skk_sticky_key 自体を返す
        " ;; で ▽* 、;k; で ▽* ではなく、; になるように
        let kana = s:SkkCleanRom() " kana は n の場合に ん になる
        if kana == '' && s:SkkCursorCol() == b:skk_hstart +
              \ strlen(g:skk_marker_white)
          call s:SkkKakutei() " ▽の削除 ( 確定 )
          return g:skk_sticky_key
        endif
        if b:skk_rstart == 0 || b:skk_line != s:SkkCursorLine()
          let b:skk_line = s:SkkCursorLine()
          let b:skk_rstart = s:SkkCursorCol()
        endif
        let b:skk_ostart = strlen(kana) + b:skk_rstart
        let b:skk_rstart = strlen(kana) + b:skk_rstart +
              \ strlen(g:skk_marker_okuri)
        let b:skk_henkan_mode = 2
        return kana . g:skk_marker_okuri
      elseif stridx(g:skk_henkan_point_keys, a:char) != -1 && b:skk_abbrev_mode_on == 0
        return SkkSetHenkanPoint(a:char)
      elseif b:skk_henkan_mode == 1 && a:char ==# g:skk_start_henkan_key
        return SkkStartHenkan()
      elseif b:skk_henkan_mode == 1 && s:SkkInCompletion() && a:char ==# g:skk_prev_comp_key
        return s:SkkPrevComp()
      elseif b:skk_henkan_mode == 1 && s:SkkInCompletion() && a:char ==# g:skk_next_comp_key
        return s:SkkCompletion(0)
      elseif b:skk_henkan_mode == 1 && a:char ==# g:skk_completion_key
        return s:SkkCompletion(!s:SkkInCompletion())
      elseif b:skk_abbrev_mode_on == 1
        return a:char
      elseif b:skk_henkan_mode == 1 && stridx(g:skk_special_midasi_keys, a:char) != -1
        return SkkStartHenkan(">")
      elseif b:skk_henkan_mode == 2
        return SkkSetHenkanPoint(a:char)
      else
        return s:SkkInsertKana(a:char)
      endif
    catch /^skk .* mark$/
      return s:SkkInsert(a:char)
    catch /^Vim.*:E132:/
      call s:SkkEcho( "SKK: Sorry, 'maxfuncdepth' is exhausted.\nSKK: Please increase 'maxfuncdepth'.", "ErrorMsg", 2)
      return s:SkkCancel()
    endtry
  endif
endfunction

" SkkInsertKana
" ひらがな、カタカナを入力する。
function! s:SkkInsertKana(char)
  call s:SkkEraseRom()
  if b:skk_rstart == 0 || b:skk_line != s:SkkCursorLine()
    let b:skk_line = s:SkkCursorLine()
    let b:skk_rstart = s:SkkCursorCol()
  endif
  let kana = ''
  let cur = b:skk_rom . a:char
  let curv = b:skk_romv . s:ValidVarChar(a:char)
  while 1
    if exists("s:skk_rules_{curv}_func") && !s:HasChild(curv)
      let b:skk_rom = s:GetRest(curv)
      let b:skk_romv = s:ValidVarChar(b:skk_rom)
      exe "return " . s:skk_rules_{curv}_func
    elseif exists("s:skk_rules_{curv}")
      if !s:HasChild(curv)
        " 確定する
        let s = s:SkkGetKana(s:skk_rules_{curv})
        let kana = kana . s
        let cur = s:GetRest(curv)
        let curv = s:ValidVarChar(cur)
        let b:skk_rstart = b:skk_rstart + strlen(s)
        let kana = kana . cur
      else
        " 確定要素はあるがまだ続く可能性もある
        let kana = kana . cur
      endif
    elseif b:skk_rom != ''
      if exists("s:skk_rules_{b:skk_romv}")
        if s:IsInclude(b:skk_rom, a:char)
          " do nothing
          let kana = kana . cur
        else
          " rom 確定 char 残す
          let s = s:SkkGetKana(s:skk_rules_{b:skk_romv})
          let kana = kana . s
          let cur = s:GetRest(b:skk_romv) . a:char
          let curv = s:ValidVarChar(cur)
          let b:skk_rom = ''
          let b:skk_romv = ''
          let b:skk_rstart = b:skk_rstart + strlen(s)
          continue	" 次のループへ
        endif
      else
        if s:IsInclude(b:skk_romv, a:char)
          " do nothing
          let kana = kana . cur
        else
          " maybe TYPO 今までのローマ字を捨てて char から始める
          let b:skk_rom = ''
          let b:skk_romv = ''
          let cur = a:char
          let curv = s:ValidVarChar(cur)
          continue	" 次のループへ
        endif
      endif
    else	" b:skk_rom == ''
      if s:HasChild(curv)
        " do nothing
        let kana = kana . cur
      else
        " rules にない単一の文字 (そのまま入力)
        let cur = ''
        let curv = ''
        let kana = kana . a:char
        let b:skk_rstart = b:skk_rstart + strlen(a:char)
      endif
    endif
    " continue | return 以外はすべてここに来る。
    break
  endwhile
  let b:skk_rom = cur
  let b:skk_romv = curv
  return kana
endfunction

" SkkInsertZenei
" 全角英数を入力する。
function! s:SkkInsertZenei(char)
  let nr = char2nr(a:char)
  if exists("s:skk_zenei_rules_{nr}")
    return s:skk_zenei_rules_{nr}
  else
    return a:char
  endif
endfunction

function! SkkCurrentKuten(kana)
  let b:skk_rstart = 0
  let kuten = matchstr(g:skk_kutouten_{g:skk_kutouten_type}, "^.")
  return a:kana . kuten
endfunction

function! SkkCurrentTouten(kana)
  let b:skk_rstart = 0
  let touten = matchstr(g:skk_kutouten_{g:skk_kutouten_type}, ".$")
  return a:kana . touten
endfunction
" }}}

" Henkan functions {{{

" マーカーのチェック 諦めが早い。
" マーカーより前で削除・挿入が行われたときは見付けられない。
function! s:SkkCheckMarker(mark, point)
  let line = strpart(s:SkkGetLine("."), a:point - 1)
  return stridx(line, a:mark) == 0
endfunction

" 変換の状態を変化させる。
" ■モードなら▽モードに、▽モードなら▽モード(送りがな入力中)に変化させる。
" ▽モード(送りがな入力中)にローマ字が空になったら変換を開始する。
function! SkkSetHenkanPoint(char)
  if b:skk_henkan_mode == 0
    let kana = SkkSetHenkanPoint1("")
    return kana . s:SkkInsertKana(s:SkkDowncase(a:char))
  elseif b:skk_henkan_mode == 1
    if !s:SkkCheckMarker(g:skk_marker_white, b:skk_hstart)
      let b:skk_henkan_mode = 0
      throw "skk cannot find " . g:skk_marker_white . " mark"
    endif
    let kana = s:SkkInsertKana(s:SkkDowncase(a:char))
    if b:skk_rom == ''
      " 変換開始
      let b:skk_ostart = s:SkkCursorCol()
      " for KAnji  ▽*か → ▽かんじ
      if b:skk_ostart == b:skk_hstart + strlen(g:skk_marker_white)
        let b:skk_ostart = 0
        return kana
      endif
      let b:skk_okurigana = kana
      return SkkStartHenkan()
    else
      let b:skk_ostart = b:skk_rstart
      let b:skk_rstart = b:skk_rstart + strlen(g:skk_marker_okuri)
      let b:skk_henkan_mode = 2
      " for KanJi  ▽か*んじ → ▽かん*じ
      if b:skk_ostart > s:SkkCursorCol()
        let p = b:skk_ostart - s:SkkCursorCol()
        return strpart(kana, 0, p) . g:skk_marker_okuri . strpart(kana, p)
      else
        return g:skk_marker_okuri . kana
      endif
    endif
  else	" b:skk_henkan_mode == 2
    if !s:SkkCheckMarker(g:skk_marker_okuri, b:skk_ostart)
      let b:skk_henkan_mode = 1
      let b:skk_ostart = 0
      throw "skk cannot find " . g:skk_marker_okuri . " mark"
    endif
    if !s:SkkCheckMarker(g:skk_marker_white, b:skk_hstart)
      let b:skk_henkan_mode = 0
      throw "skk cannot find " . g:skk_marker_white . " mark"
    endif
    if a:char ==# g:skk_start_henkan_key
      let kana = s:SkkCleanRom()
      let okuri = strpart(s:SkkGetLine("."), b:skk_ostart, s:SkkCursorCol() - b:skk_ostart - 1) . kana
      if okuri != ""
        let b:skk_okurigana = okuri
        return SkkStartHenkan()
      endif
      let c = s:SkkEcho("No okurigana!", "WarningMsg", 1)
      return c == "" ? "" : SkkSetHenkanPoint(c)
    endif
    " for KanJI  ▽かん*j → ▽かん*I → ▽かん*じ
    let kana = s:SkkInsertKana(s:SkkDowncase(a:char))
    if b:skk_rom == ''
      " 変換開始
      let b:skk_okurigana = strpart(s:SkkGetLine("."), b:skk_ostart, s:SkkCursorCol() - b:skk_ostart - 1) . kana
      return SkkStartHenkan()
    else
      return kana
    endif
  endif
endfunction

" kana の入力後に▽モードにする。
function! SkkSetHenkanPoint1(kana)
  if b:skk_henkan_mode == 0
    call s:SkkEraseRom()
    let kana = a:kana
    if b:skk_romv != "" && exists("s:skk_rules_{b:skk_romv}")
      let kana = kana . s:SkkGetKana(s:skk_rules_{b:skk_romv})
      let b:skk_rom = ""
      let b:skk_romv = ""
    endif
  else
    let kana = a:kana . s:SkkKakutei()
  endif
  let b:skk_hstart = s:SkkCursorCol() + strlen(kana)
  let b:skk_rstart = b:skk_hstart + strlen(g:skk_marker_white)
  let b:skk_line = s:SkkCursorLine()
  let b:skk_ostart = 0
  let b:skk_okurigana = ""
  let b:skk_henkan_mode = 1
  return kana . g:skk_marker_white
endfunction

function! s:SkkAscii2Zenei(str)
  let result = ""
  let i = 0
  let char = matchstr(a:str, ".", 0)
  while char != ""
    let nr = char2nr(char)
    if exists("s:skk_zenei_rules_{nr}")
      let result = result . s:skk_zenei_rules_{nr}
    else
      let result = result . char
    endif
    let i = i + strlen(char)
    let char = matchstr(a:str, ".", i)
  endwhile
  return result
endfunction

function! s:SkkHira2Kata(str)
  let str = substitute(a:str, "う゛", "ヴ", "g")
  let i = 0
  let result = ''
  let char = matchstr(str, ".", 0)
  while char != ''
    let pos = stridx(s:skk_hiragana, char)
    if pos != -1
      let result = result . matchstr(s:skk_katakana, ".", pos)
    else
      let result = result . char
    endif
    let i = i + strlen(char)
    let char = matchstr(str, ".", i)
  endwhile
  return result
endfunction

function! s:SkkKata2Hira(str)
  let i = 0
  let result = ''
  let char = matchstr(a:str, ".", 0)
  while char != ''
    if char == "ヴ"
      let result = result . "う゛"
    else
      let pos = stridx(s:skk_katakana, char)
      if pos != -1
        let result = result . matchstr(s:skk_hiragana, ".", pos)
      else
        let result = result . char
      endif
    endif
    let i = i + strlen(char)
    let char = matchstr(a:str, ".", i)
  endwhile
  return result
endfunction

function! s:SkkGetHenkanKey(midasi, okuri)
  let table = "xaxixuxexokgkgkgkgkgszsjszszsztdtdttdtdtdnnnnnhbphbphbphbphbpmmmmmxyxyxyrrrrrxwxxwn"
  let head = matchstr(a:okuri, ".")
  if head >= "ぁ" && head <= "ん"
    let ch = table[char2nr(head) - char2nr("ぁ")]
  else
    let ch = ''
  endif
  let key = a:midasi . ch . " "
  return g:skk_use_numeric_conversion ? s:SkkGetNumHenkanKey(key) : key
endfunction

" 変換開始又は次の候補
" 引数を見るのは初めての変換のときだけ。
function! SkkStartHenkan(...)
  if b:skk_henkan_mode == 3
    " 2回目以降の変換
    if b:skk_current_cand >= b:skk_cand_count - 1
      if !b:skk_large_jisyo_searched
        call s:SkkAddCandidates(s:SkkSearch(1))
        return SkkStartHenkan()
      endif
      " 単語登録
      call s:SkkEraseYomi()
      " キャンセルされた場合に SkkPreviousCand で元に戻れるように。
      let b:skk_current_cand = b:skk_current_cand + 1
      return s:SkkTourokuMode()
    endif
    call s:SkkEraseYomi()
    let b:skk_current_cand = b:skk_current_cand + 1
    if b:skk_current_cand >= g:skk_show_candidates_count
      if !b:skk_large_jisyo_searched
        call s:SkkAddCandidates(s:SkkSearch(1))
      endif
      return s:SkkSelectCandidate()
    else
      let cand = s:SkkGetCandStrConverted(b:skk_current_cand)
      call s:SkkFaceOn(cand)
      return g:skk_marker_black . cand . b:skk_okurigana
    endif
  else
    " 初めての変換
    if !s:SkkCheckMarker(g:skk_marker_white, b:skk_hstart)
      let b:skk_henkan_mode = 0
      throw "skk cannot find " . g:skk_marker_white . " mark"
    endif
    let kana = s:SkkCleanRom()
    if a:0 > 0
      let kana = kana . a:1
    endif
    let line = s:SkkGetLine(".")
    if b:skk_ostart == 0
      let b:skk_ostart = s:SkkCursorCol()
      let b:skk_okurigana = ''
    endif
    let b:skk_henkan_mode = 3
    let hstart = b:skk_hstart + strlen(g:skk_marker_white) - 1
    let b:skk_midasi = strpart(line, hstart, b:skk_ostart - 1 - hstart) . kana
    if b:skk_midasi == ""
      call s:SkkEraseYomi()
      let b:skk_henkan_mode = 0
      return ""
    endif
    if b:skk_mode == 'kata'
      let b:skk_henkan_key = s:SkkGetHenkanKey(s:SkkKata2Hira(b:skk_midasi), s:SkkKata2Hira(b:skk_okurigana))
    else
      let b:skk_henkan_key = s:SkkGetHenkanKey(b:skk_midasi, b:skk_okurigana)
    endif
    let b:skk_large_jisyo_searched = 0
    let cand = s:SkkMakeCandidates(s:SkkSearch(0))
    call s:SkkEraseYomi()
    if cand == ''
      if !b:skk_large_jisyo_searched
        call s:SkkAddCandidates(s:SkkSearch(1))
      endif
      if b:skk_cand_count == 0
        " 単語登録
        return s:SkkTourokuMode()
      else
        let cand = s:SkkGetCandStrConverted(0)
        call s:SkkFaceOn(cand)
        return g:skk_marker_black . cand .  b:skk_okurigana
      endif
    else
      call s:SkkFaceOn(cand)
      return g:skk_marker_black . cand . b:skk_okurigana
    endif
  endif
endfunction

function! SkkPreviousCand()
  if b:skk_current_cand <= 0
    return s:SkkCancel()
  endif
  let b:skk_current_cand = b:skk_current_cand - 1
  call s:SkkEraseYomi()
  if b:skk_current_cand >= g:skk_show_candidates_count
    return s:SkkSelectCandidate()
  else
    let cand = s:SkkGetCandStrConverted(b:skk_current_cand)
    call s:SkkFaceOn(cand)
    return g:skk_marker_black . cand . b:skk_okurigana
  endif
endfunction

function! SkkHenkan(char)
  if a:char ==# g:skk_start_henkan_key
    " 次候補
    return SkkStartHenkan()
  elseif a:char ==# g:skk_prev_cand_key
    " 前候補
    return SkkPreviousCand()
  elseif a:char ==# g:skk_purge_cand_key
    return SkkPurgeFromJisyo()
  elseif stridx(g:skk_special_midasi_keys, a:char) != -1
    " TODO 接尾辞入力: ">" というローマ字がないことを前提にしている。
    call s:SkkKakutei()
    return SkkSetHenkanPoint(">")
  else
    " 確定 & char入力
    call s:SkkKakutei()
    return s:SkkInsert(a:char)
  endif
endfunction

function! s:SkkKakutei()
  let kana = ""
  if b:skk_henkan_mode == 0
    let kana = s:SkkCleanRom()
  elseif b:skk_henkan_mode == 1
    let kana = s:SkkCleanRom()
    let end = b:skk_hstart + strlen(g:skk_marker_white)
    call s:SkkDeleteRange(b:skk_line, b:skk_hstart, end)
  elseif b:skk_henkan_mode == 2
    " 送り仮名も削除する
    call s:SkkDeleteRange(b:skk_line, b:skk_ostart, s:SkkCursorCol())
    let end = b:skk_hstart + strlen(g:skk_marker_white)
    call s:SkkDeleteRange(b:skk_line, b:skk_hstart, end)
  elseif b:skk_henkan_mode == 3
    call s:SkkFaceOff()
    let end = b:skk_hstart + strlen(g:skk_marker_black)
    call s:SkkDeleteRange(b:skk_line, b:skk_hstart, end)
    " 辞書に書き込むのは状態3と4だけ。
    call s:SkkUpdateJisyo(b:skk_cand_{b:skk_current_cand})
  elseif b:skk_henkan_mode == 4
    call s:SkkFaceOff()
    call s:SkkUpdateJisyo(b:skk_cand_{b:skk_current_cand})
  endif
  let b:skk_henkan_mode = 0
  let b:skk_rom = ''
  let b:skk_romv = ''
  let b:skk_rstart = 0
  let b:skk_abbrev_mode_on = 0
  call s:SkkSetCursorColor()
  return kana
endfunction

" 選択方式で候補を選択する。
function! s:SkkSelectCandidate()
  try
    let &ruler = 0	" Hit ENTER の表示を避けるため
    call s:SkkUnmapNormal()
    let str = ''
    let keys = toupper(g:skk_select_cand_keys)
    let keyslen = strlen(keys)
    let i = 0
    let cand = (b:skk_current_cand - g:skk_show_candidates_count) * keyslen + g:skk_show_candidates_count
    if cand >= b:skk_cand_count
      " 単語登録
      return s:SkkTourokuMode()
    endif
    while cand < b:skk_cand_count && i < keyslen
      if g:skk_show_annotation
        let str = str . keys[i] . ":" . s:SkkGetCandStrWithAnnotation(cand) . "  "
      else
        let str = str . keys[i] . ":" . s:SkkGetCandStrConverted(cand) . "  "
      endif
      let i = i + 1
      let cand = cand + 1
    endwhile
    let rest = b:skk_cand_count - cand
    let str = str . "[残り " . rest . "]"
    let lines = (strlen(str) + &columns) / &columns
    if lines > &cmdheight
      let saved_cmdheight = &cmdheight
      let &cmdheight = lines
    endif
    echo str
    while 1
      " TODO ここで関数の入れ子が深くなってしまうのをなんとかしたい。
      let key = nr2char(getchar())
      if key ==# g:skk_start_henkan_key
        let b:skk_current_cand = b:skk_current_cand + 1
        return s:SkkSelectCandidate()
      elseif key ==# g:skk_prev_cand_key
        if b:skk_current_cand - 1 < g:skk_show_candidates_count
          return SkkPreviousCand()
        else
          let b:skk_current_cand = b:skk_current_cand - 1
          return s:SkkSelectCandidate()
        endif
      elseif key == "\<C-g>"
        return s:SkkCancel()
      endif
      let select = stridx(keys, toupper(key))
      if select == -1 || select >= i
        " TODO 何かメッセージを出したほうがいいか？
        continue
      endif
      let nr = cand - i + select
      let b:skk_current_cand = nr
      let b:skk_henkan_mode = 4
      call s:SkkKakutei()
      return s:SkkGetCandStrConverted(nr) . b:skk_okurigana
    endwhile
  finally
    "echo substitute(str, ".", " ", "g")
    echon
    let &ruler = 1
    if exists("saved_cmdheight")
      let &cmdheight = saved_cmdheight
    endif
  endtry
endfunction

function! s:SkkSaveEnv()
  let env = 'b:skk_rstart = ' . b:skk_rstart . "\<NL>"
  let env = env . 'b:skk_line = ' . b:skk_line . "\<NL>"
  let env = env . 'b:skk_hstart = ' . b:skk_hstart . "\<NL>"
  let env = env . 'b:skk_ostart = ' . b:skk_ostart . "\<NL>"
  let env = env . 'b:skk_cand_count = ' . b:skk_cand_count . "\<NL>"
  let env = env . 'b:skk_current_cand = ' . b:skk_current_cand . "\<NL>"
  let env = env . 'b:skk_henkan_mode = ' . b:skk_henkan_mode . "\<NL>"
  let env = env . 'b:skk_mode = "' . b:skk_mode . "\"\<NL>"
  let env = env . 'b:skk_midasi = "' . escape(b:skk_midasi, '"\') . "\"\<NL>"
  let env = env . 'b:skk_okurigana = "' . escape(b:skk_okurigana, '"\') . "\"\<NL>"
  let env = env . 'b:skk_henkan_key = "' . escape(b:skk_henkan_key, '"\') . "\"\<NL>"
  let env = env . 'b:skk_abbrev_mode_on = "' . b:skk_abbrev_mode_on . "\"\<NL>"
  let env = env . 'b:skk_num_list_count = "' . b:skk_num_list_count . "\"\<NL>"
  let env = env . 's:skk_in_cmdline = ' . s:skk_in_cmdline . "\<NL>"
  if exists("s:skk_cur_col")
    let env = env . 's:skk_cur_col = ' . s:skk_cur_col . "\<NL>"
  endif
  if exists("s:skk_cur_line")
    let env = env . 's:skk_cur_line = ' . s:skk_cur_line . "\<NL>"
  endif
  if exists("s:skk_bs_str")
    let env = env . 's:skk_bs_str = "' . s:SkkQuoteChar(s:skk_bs_str, 1) . "\"\<NL>"
  endif
  let i = 0
  while i < b:skk_cand_count
    let env = env . "b:skk_cand_" . i . " = \"" . s:SkkQuoteChar(b:skk_cand_{i}, 1) . "\"\<NL>"
    let i = i + 1
  endwhile
  let i = 0
  while i < b:skk_num_list_count
    let env = env . "b:skk_num_list_" . i . " = \"" . s:SkkQuoteChar(b:skk_num_list_{i}, 1) . "\"\<NL>"
    let i = i + 1
  endwhile
  return env
endfunction

function! s:SkkRestoreEnv(env)
  let ptr = a:env
  while ptr != ''
    let line = matchstr(ptr, "^[^\<NL>]*")
    let ptr = strpart(ptr, strlen(line) + 1)
    silent exe "let " . line
  endwhile
endfunction

" 単語登録モードに入る。
function! s:SkkTourokuMode()
  let str = b:skk_midasi
  if g:skk_use_numeric_conversion
    let str = s:SkkGetNumHenkanKey(str)
  endif
  if b:skk_okurigana != ''
    let str = str . g:skk_marker_okuri . b:skk_okurigana
  endif
  let enter_touroku = !exists("s:skk_in_touroku")
  if enter_touroku
    let s:skk_in_touroku = 1
    call SkkMap(0)
    cnoremap <buffer> <C-g> <C-\>e<SID>SkkCmdCancel()<CR>
    let cmd = "call cursor(" . line(".") . ", " . col(".") . ")"
  endif
  let prev = s:SkkGetLine(0)
  let prevpos = s:SkkCursorCol()
  unlet! s:skk_cmdline_str s:skk_cmdline_pos
  let env = s:SkkSaveEnv()
  let ims_save = &imsearch
  try
    let b:skk_henkan_mode = 0
    let b:skk_abbrev_mode_on = 0
    let &imsearch = 1
    redraw
    let result = input(str . " ")
    call s:SkkRestoreEnv(env)
    unlet! s:skk_cmdline_str s:skk_cmdline_pos
    if result == ''
      return SkkPreviousCand()
    endif
    call s:SkkUpdateJisyo(result)
    if g:skk_use_numeric_conversion && b:skk_num_list_count > 0
      let old_count = b:skk_cand_count
      call s:SkkProcessNumCandidate(result)
      let result = s:SkkGetCandStrConverted(old_count)
      if b:skk_cand_count - old_count == 1
        let b:skk_henkan_mode = 0
      else
        let result = g:skk_marker_black . result
        call s:SkkFaceOn(result)
      endif
    else
      let b:skk_henkan_mode = 0
    endif
    if b:skk_henkan_mode == 0
      let b:skk_abbrev_mode_on = 0
      call s:SkkFaceOff()
    endif
    return result . b:skk_okurigana
  catch /^Vim:Interrupt$\|^skk CmdCancel$/
    call s:SkkRestoreEnv(env)
    return SkkPreviousCand()
  finally
    " skk を off にされたときのため
    if b:skk_on == 0
      call s:SkkOn()
    end
    let &imsearch = ims_save
    let s:skk_cmdline_str = prev
    let s:skk_cmdline_pos = prevpos
    if enter_touroku
      silent! cunmap <buffer> <C-g>
      call SkkMap(mode() != "c")
      unlet s:skk_in_touroku
      if s:skk_in_cmdline == 0
        exe cmd
      endif
    endif
  endtry
endfunction
" }}}

" dictionary functions {{{

" 複数の vim で同じ辞書を開いても大丈夫な (swapfile の警告が出ない) ように
" 仮のバッファを作ってそこに読み込む。
function! s:SkkGetJisyoBuf(var)
  if exists("s:{a:var}_bufnr")
    if bufexists(s:{a:var}_bufnr)
      return s:{a:var}_bufnr
    endif
    call s:SkkEcho("SKK: Someone deleted JISYO buffer!!", "WarningMsg", 0)
  endif
  let s:{a:var}_bufname = tempname()
  let s:{a:var}_ftime = getftime(expand(g:{a:var}))
  let s:{a:var}_fsize = getfsize(expand(g:{a:var}))
  let s:{a:var}_modified = 0
  silent exe "badd " . s:{a:var}_bufname
  let s:{a:var}_bufnr = bufnr(s:{a:var}_bufname)
  let cmd = s:SkkShowBuf(s:{a:var}_bufnr)
  try
    silent! exe "r " . g:{a:var}
    silent exe "bw " . g:{a:var}
    normal! gg"_dd
    " 1行目に okuri-ari entries. があると見つけられないためこの順序にした。
    let b:skk_okuri_nasi_line = search("^;; okuri-nasi entries.$", "W")
    let b:skk_okuri_ari_line = search("^;; okuri-ari entries.$", "bW")
    if b:skk_okuri_nasi_line == 0 && b:skk_okuri_ari_line == 0 && line("$") == 1
      " 新規ファイル
      call setline(1, ";; okuri-ari entries.")
      call append(1, ";; okuri-nasi entries.")
      let b:skk_okuri_ari_line = 1
      let b:skk_okuri_nasi_line = 2
    endif
    " TODO 不正なファイルの処理
    setlocal nobuflisted buftype=nowrite bufhidden=hide
    return s:{a:var}_bufnr
  finally
    exe cmd
  endtry
endfunction

function! s:SkkRestoreWincol(cnum)
  let c = wincol()
  if a:cnum > c
    exe "normal! " . (a:cnum - c) . "zh"
  elseif a:cnum < c
    exe "normal! " . (c - a:cnum) . "zl"
  endif
endfunction

" 現在のバッファに戻るためのコマンドを返す。
function! s:SkkShowBuf(buf)
  let cmd = bufnr("%") . "buffer"
  let cur = "|call cursor(" . line(".") . ", " . col(".") . ")"
  let wc = wincol()
  normal! H
  let cmd = cmd . "|exe \"normal! " . line(".") . "zt\""
  if &wrap == 0
    let cmd = cmd . cur . "|call s:SkkRestoreWincol(" . wc . ")"
  endif
  let cmd = cmd . cur
  if &bufhidden != "hide"
    let cmd = cmd . "|let &bufhidden = \"" . &bufhidden . "\""
    let &bufhidden = "hide"
  endif
  exe a:buf . "buffer"
  return cmd
endfunction

function! s:SkkSearch(large)
  let cand = ''
  if !a:large
    let buf = s:SkkGetJisyoBuf("skk_jisyo")
    let cand = s:SkkSearchBuf(buf, 0)
  endif
  if cand == '' || a:large
    if g:skk_external_prog != ""
      if b:skk_henkan_key !~ "'"
        let cand = system(g:skk_external_prog . " '" . b:skk_henkan_key . "'")
      endif
    else
      let buf = s:SkkGetJisyoBuf("skk_large_jisyo")
      let cand = s:SkkSearchBuf(buf, 1000)
    endif
    let b:skk_large_jisyo_searched = 1
  endif
  return cand
endfunction

function! s:SkkSearchBuf(buf, limit)
  let okuri = strlen(b:skk_okurigana)
  let key = "^" . b:skk_henkan_key	" バッファが変わるので保存しておく。
  let cmd = s:SkkShowBuf(a:buf)
  try
    if a:limit == 0
      return SkkSearchLinear(key, okuri)
    else
      return SkkSearchBinary(key, okuri, a:limit)
    endif
  finally
    exe cmd
  endtry
endfunction

" リニアサーチ ソートしていないファイル用
" 送りなしエントリの先頭に移動して送りありなら先頭方向に
" 送りなしなら末尾方向に検索する。
function! SkkSearchLinear(key, okuri)
  if b:skk_okuri_nasi_line
    if a:okuri != ""
      let flag = "bW"
      exe "normal! " . b:skk_okuri_nasi_line . "G0"
    else
      let flag = "W"
      exe "normal! " . b:skk_okuri_nasi_line . "G$"
    endif
  else
    let flag = "W"
    exe "normal! 1G0"
  endif
  let key = escape(a:key, '$.*\[]') . '\m'
  let b:skk_found_lnum = search(key, flag)
  return substitute(getline(b:skk_found_lnum), key, '', '')
endfunction

" バイナリサーチ ソート済ファイル用
" 送りありエントリは降順に、送りなしエントリは昇順にソートされている必要がある。
" 検索範囲が limit 以下になるまで二分検索を行い、その後、リニアサーチする。
" search() が最後まで検索してしまうため最悪の場合は SkkSearchLinear より遅い。
function! SkkSearchBinary(key, okuri, limit)
  if b:skk_okuri_nasi_line == 0
    return SkkSearchLinear(a:key, a:okuri)
  endif
  let key = strpart(a:key, 1)	" remove ^
  if a:okuri
    let min = b:skk_okuri_ari_line + 1
    let max = b:skk_okuri_nasi_line - 1
  else
    let min = b:skk_okuri_nasi_line + 1
    let max = line("$")
  endif
  while max - min > a:limit
    let mid = (max + min) / 2
    let line = getline(mid)
    if key >=# line
      if a:okuri
        let max = mid
      else
        let min = mid
      endif
    else
      if a:okuri
        let min = mid
      else
        let max = mid
      endif
    endif
  endwhile
  if a:okuri
    let flag = "bW"
    let max = max + 1	" max 行を含めるため
    exe "normal! " . max . "G0"
  else
    let flag = "W"
    let min = min - 1	" min 行を含めるため
    exe "normal! " . min . "G$"
  endif
  let key = escape(a:key, '$.*\[]') . '\m'
  let b:skk_found_lnum = search(key, flag)
  return substitute(getline(b:skk_found_lnum), key, '', '')
endfunction

" annotation を取り除く。
function! s:SkkRemoveAnnotation(str)
  return substitute(a:str, ';.*', '', '')
endfunction

" 候補の annotation を取り除いた本体を返す。
function! s:SkkGetCand(nr)
  return s:SkkRemoveAnnotation(b:skk_cand_{a:nr})
endfunction

" 数値変換済みの候補があればそれを返す。なければ SkkGetCand と同じ。
function! s:SkkGetCandStr(nr)
  if exists("b:skk_cand_{a:nr}_str")
    return s:SkkRemoveAnnotation(b:skk_cand_{a:nr}_str)
  else
    return s:SkkGetCand(a:nr)
  endif
endfunction

" SkkGetCandStr() と同様だが、annotationを除去しない。
function! s:SkkGetCandStrWithAnnotation(nr)
  if exists("b:skk_cand_{a:nr}_str")
    let str = b:skk_cand_{a:nr}_str
  else
    let str = b:skk_cand_{a:nr}
  endif
  return b:skk_mode == 'kata' ? s:SkkHira2Kata(str) : str
endfunction

" SkkGetCandStr() と同様だが、skk_mode を見て必要があればカタカナ変換する。
function! s:SkkGetCandStrConverted(nr)
  let str = s:SkkGetCandStr(a:nr)
  return b:skk_mode == 'kata' ? s:SkkHira2Kata(str) : str
endfunction

" (concat "") の処理 (結果の文字列を返す)
function! s:SkkConcat(str)
  let cand = ""
  let quote1 = match(a:str, '"', 0)
  let quote2 = match(a:str, '\\\@<!"', quote1 + 1)
  while quote1 != -1 && quote2 != -1
    let s = strpart(a:str, quote1, quote2 - quote1 + 1)
    if strlen(s) > 2	" \"\" を含むため
      " quote されているものを復元するため exe を使う。
      exe "let s = " . s
      let cand = cand . s
    endif
    let quote1 = match(a:str, '"', quote2 + 1)
    let quote2 = match(a:str, '\\\@<!"', quote1 + 1)
  endwhile
  return cand
endfunction

" (skk-ignore-dic-word "") の処理
function! s:SkkIgnoreWords(words)
  let quote1 = match(a:words, '"', 0)
  let quote2 = match(a:words, '\\\@<!"', quote1 + 1)
  while quote1 != -1 && quote2 != -1
    let s = strpart(a:words, quote1, quote2 - quote1 + 1)
    if strlen(s) > 2	" \"\" を含むため
      " quote されているものを復元するため exe を使う。
      exe "let b:skk_ignore_{b:skk_ignore_count} = " . s
      " (concat "") が含まれていたとしても SkkConcat を処理する前に
      " SkkNotIgnoreWord で比較されるので問題ない。
      let b:skk_ignore_count = b:skk_ignore_count + 1
    endif
    let quote1 = match(a:words, '"', quote2 + 1)
    let quote2 = match(a:words, '\\\@<!"', quote1 + 1)
  endwhile
endfunction

function! s:SkkNotIgnoreWord(word)
  let i = 0
  while i < b:skk_ignore_count
    if a:word ==# b:skk_ignore_{i}
      return 0
    endif
    let i = i + 1
  endwhile
  return 1
endfunction

" 重複する要素を除いて候補を追加していく。
function! s:SkkAddCand(cand, str, compare)
  let i = 0
  if a:str != ""
    let cand = s:SkkRemoveAnnotation(a:str)
  else
    let cand = s:SkkRemoveAnnotation(a:cand)
  endif
  while i < a:compare
    if s:SkkGetCandStr(i) ==# cand
      return
    endif
    let i = i + 1
  endwhile
  let b:skk_cand_{b:skk_cand_count} = a:cand
  if a:str != ""
    let b:skk_cand_{b:skk_cand_count}_str = a:str
  endif
  let b:skk_cand_count = b:skk_cand_count + 1
endfunction

function! s:SkkSplitCandidates(str)
  let sla1 = match(a:str, '/', 0)
  let sla2 = match(a:str, '/', sla1 + 1)
  let compare = b:skk_cand_count
  while sla2 != -1
    let s = strpart(a:str, sla1 + 1, sla2 - sla1 - 1)
    if match(s, "^(skk-ignore-dic-word ") == 0
      call s:SkkIgnoreWords(s)
    elseif strlen(s) > 0 && s:SkkNotIgnoreWord(s)
      if match(s, "^(concat ") == 0
        let s = s:SkkConcat(s)
      endif
      if g:skk_use_numeric_conversion && b:skk_num_list_count > 0
        call s:SkkProcessNumCandidate(s)
      else
        call s:SkkAddCand(s, "", compare)
      endif
    endif
    let sla1 = sla2
    let sla2 = match(a:str, '/', sla1 + 1)
  endwhile
endfunction

" 初期化しないで候補を追加する。
function! s:SkkAddCandidates(str)
  let str = substitute(a:str, '/\[[^]]*/\]', '', 'g') " 送りがなの指定は無視する。
  call s:SkkSplitCandidates(str)
endfunction

" 新たに候補をゼロから作る。
function! s:SkkMakeCandidates(str)
  call s:SkkCleanupCandidates()
  call s:SkkAddCandidates(a:str)
  return b:skk_cand_count == 0 ? '' : s:SkkGetCandStrConverted(0)
endfunction

function! s:SkkCleanupCandidates()
  if exists("b:skk_cand_count")
    let i = 0
    while i < b:skk_cand_count
      unlet b:skk_cand_{i}
      unlet! b:skk_cand_{i}_str
      let i = i + 1
    endwhile
  endif
  if exists("b:skk_ignore_count")
    let i = 0
    while i < b:skk_ignore_count
      unlet b:skk_ignore_{i}
      let i = i + 1
    endwhile
  endif
  let b:skk_cand_count = 0
  let b:skk_current_cand = 0
  let b:skk_ignore_count = 0
endfunction

function! s:SkkValidCand(cand)
  if match(a:cand, "[/\n\r\\\"]") == -1
    return a:cand
  else
    return "(concat \"" . s:SkkQuoteChar(a:cand, 1) . "\")"
  endif
endfunction

function! s:SkkMakeNewEntry(key, cand, line)
  let entry = a:key . '/' . a:cand . '/'
  let sla1 = match(a:line, '/', 0)
  if a:line[sla1 + 1] == '['
    let sla2 = matchend(a:line, '/\]/', sla1 + 1) - 1
  else
    let sla2 = match(a:line, '/', sla1 + 1)
  endif
  while sla2 != -1
    let s = strpart(a:line, sla1 + 1, sla2 - sla1 - 1)
    let sla1 = sla2
    if a:line[sla1 + 1] == '['
      let sla2 = matchend(a:line, '/\]/', sla1 + 1) - 1
    else
      let sla2 = match(a:line, '/', sla1 + 1)
    endif
    if s ==# a:cand
      continue
    endif
    let entry = entry . s . '/'
  endwhile
  return entry
endfunction

" 確定した候補を辞書バッファに書き込む。
function! s:SkkUpdateJisyo(word)
  let buf = s:SkkGetJisyoBuf("skk_jisyo")
  if getbufvar(buf, "&readonly") || a:word == ""
    return
  endif
  let key = b:skk_henkan_key
  let okuri= strlen(b:skk_okurigana)
  let cmd = s:SkkShowBuf(buf)
  try
    " 重複を避けるため、もう一回検索する。
    let line = SkkSearchLinear("^" . key, okuri)
    let str = s:SkkMakeNewEntry(key, s:SkkValidCand(a:word), line)
    if b:skk_found_lnum
      exe "normal! " . b:skk_found_lnum . "G\"_dd"
    endif
    let lnum = okuri ? b:skk_okuri_ari_line : b:skk_okuri_nasi_line
    call append(lnum, str)
    if okuri && b:skk_found_lnum == 0
      let b:skk_okuri_nasi_line = b:skk_okuri_nasi_line + 1
    endif
    let s:skk_jisyo_modified = 1
  finally
    exe cmd
  endtry
endfunction

function! s:SkkLargeJisyoHasWord(word)
  let str = s:SkkSearch(1)
  return stridx(str, "/" . a:word . "/") != -1
endfunction

function! s:SkkQuoteChar(str, ...)
  let str = escape(a:str, '"\')
  if a:0 == 0
    let str = substitute(str, ";", '\\073', "g")
  endif
  let str = substitute(str, "/", '\\057', "g")
  let str = substitute(str, "\n", '\\n', "g")
  let str = substitute(str, "\r", '\\r', "g")
  return str
endfunction

function! SkkPurgeFromJisyo()
  let key = b:skk_henkan_key
  let okuri = strlen(b:skk_okurigana)
  let cand = s:SkkGetCand(b:skk_current_cand)
  if s:SkkYesNo("really purge \"" . key . "/" . cand . "/ \"?") == 0
    return ""
  endif
  let word = s:SkkValidCand(b:skk_cand_{b:skk_current_cand})
  " この時点では既に SkkIgnoreWords は処理されているはず。
  let i = 0
  let s = "(skk-ignore-dic-word \"" . s:SkkQuoteChar(word) . "\""
  let ex = "/" . word . "/"
  while i < b:skk_ignore_count
    let s = s . " \"" . s:SkkQuoteChar(b:skk_ignore_{i}) . "\""
    let ex = ex . b:skk_ignore_{i} . "/"
    let i = i + 1
  endwhile
  let s = s . ")"
  let large_has = s:SkkLargeJisyoHasWord(word)
  let buf = s:SkkGetJisyoBuf("skk_jisyo")
  let cmd = s:SkkShowBuf(buf)
  try
    if v:version < 700
      let line = SkkSearchLinear("^" . key, okuri)
    else	" vim7
      let line = s:SkkSearchBuf(buf, 0)
    endif
    let line = substitute(line, '/(skk-ignore-dic-word [^)]*)/', "/", "g")
    let line = s:SkkPurge(line, ex)
    if large_has
      let str = s:SkkMakeNewEntry(key, s, line)
    else
      let str = line == "" ? "" : key . line
    endif
    if b:skk_found_lnum && v:version < 700
      exe "normal! " . b:skk_found_lnum . "G\"_dd"
    elseif b:skk_found_lnum >= 0 && v:version >= 700
      call remove(buf, b:skk_found_lnum)
    endif
    if v:version < 700
      let lnum = okuri ? b:skk_okuri_ari_line : b:skk_okuri_nasi_line
    else	" vim7
      let lnum = okuri ? buf[0][0] + 1 : buf[0][1] + 1
    endif
    if str != ""
      if v:version < 700
        call append(lnum, str)
        if okuri && b:skk_found_lnum == 0
          let b:skk_okuri_nasi_line = b:skk_okuri_nasi_line + 1
        endif
      else	" vim7
        if buf[0][2] != &enc
          let str = iconv(str, &enc, buf[0][2])
        endif
        if buf[0][3] == "dos"
          let str = str . "\<CR>"
        endif
        call insert(buf, str, lnum)
        if okuri && b:skk_found_lnum < 0
          let buf[0][1] += 1
        endif
      endif
    endif
    let s:skk_jisyo_modified = 1
  finally
    exe cmd
  endtry
  call s:SkkFaceOff()
  call s:SkkEraseYomi()
  let b:skk_henkan_mode = 0
  return ""
endfunction

function! s:SkkSaveJisyo(confirm, silent)
  if !exists("s:skk_jisyo_fsize")
    if !a:silent
      echo "No need to save SKK jisyo"
    endif
    return
  endif
  let jisyo = expand(g:skk_jisyo)
  let fsize = getfsize(jisyo)
  let ftime = getftime(jisyo)
  if s:skk_jisyo_fsize != fsize || s:skk_jisyo_ftime != ftime
    let msg = "SKK: Someone modified " . g:skk_jisyo
    let msg = msg . "\nSKK: Stop saving " . g:skk_jisyo
    echo msg
    return
  endif
  if v:version < 700
    let need = s:skk_jisyo_bufnr != -1 && bufexists(s:skk_jisyo_bufnr) && s:skk_jisyo_modified
  else		" vim7
    let need = exists("s:skk_jisyo_list") && s:skk_jisyo_modified
    let s:skk_jisyo_bufnr = 0	" SkkShowBuf のエラー対策
  endif
  if need
    let cmd = s:SkkShowBuf(s:skk_jisyo_bufnr)
    try
      if v:version < 700
        let jisyosize = line2byte(line("$")) + strlen(getline("$"))
      else	" vim7
        let buf = s:skk_jisyo_list
        let list = buf[1:]
        if buf[0][3] == "mac"
          let list[0] = join(list, "\<CR>") . "\<CR>"
          let list = list[0:0]
        endif
        let tmp = tempname()
        call writefile(list, tmp, 'b')
        let jisyosize = getfsize(tmp)
      endif
      if jisyosize < fsize
        let msg = "SKK: New " . g:skk_jisyo . " will be " . (fsize - jisyosize)
        let msg = msg . "bytes smaller.\nSKK: Stop saving " . g:skk_jisyo
        " TODO confirm
        echo msg
        return
      endif
      if a:confirm && confirm("Do you want to save " . g:skk_jisyo . "?", "&yes\n&no") != 1
        return
      endif
      if !a:silent
        echo "Saving SKK jisyo..."
      endif
      if filereadable(jisyo)
        call rename(jisyo, expand(g:skk_backup_jisyo))
      endif
      if v:version < 700
        set buftype=
        silent exe "write " . g:skk_jisyo
        set buftype=nowrite
        " swapfile を残さないため
        silent exe "bw " . g:skk_jisyo
      else	" vim7
        call rename(tmp, jisyo)
      endif
      let s:skk_jisyo_ftime = getftime(jisyo)
      let s:skk_jisyo_fsize = jisyosize
      let s:skk_jisyo_modified = 0
      if !a:silent
        echon "\rSaving SKK jisyo...done"
      endif
    finally
      exe cmd
    endtry
  else
    if !a:silent
      echo "No need to save SKK jisyo"
    endif
  endif
endfunction

" }}}

" cmdline functions {{{

" <C-r>= だと setcmdpos() が思ったように動かないため自前で組み立てる。
function! s:SkkMakeCmdStr(str)
  if v:version >= 603
    redrawstatus
  endif
  if !exists("s:skk_cmdline_str")
    return a:str
  endif
  let result = "\<C-e>\<C-u>"
  let front = strpart(s:skk_cmdline_str, 0, s:skk_cmdline_pos - 1)
  let rear = strpart(s:skk_cmdline_str, s:skk_cmdline_pos - 1)
  if rear != ""
    let result = result . rear . "\<C-b>"
  endif
  if front != ""
    let result = result . front
  endif
  return result . a:str
endfunction

" カーソル位置に str を挿入して行全体を返す。カーソル位置も調整する。
function! s:SkkConcatCmdStr(str)
  let line = s:SkkGetLine(0)
  unlet! s:skk_cmdline_str
  let pos = s:SkkCursorCol()
  unlet! s:skk_cmdline_pos
  let line = strpart(line, 0, pos - 1) . a:str . strpart(line, pos - 1)
  call setcmdpos(pos + strlen(a:str))
  return line
endfunction

function! s:SkkCmdCancel()
  if b:skk_henkan_mode == 0
    throw 'skk CmdCancel'
  else
    return s:SkkConcatCmdStr(s:SkkCancel())
  endif
endfunction

" }}}

" Completion {{{

" b:skk_comp_key は SkkCompletion(1) のときに let され
" SkkCleanRom SkkBackspace SkkCancel の中で unlet される。
" これで他の動作が行われたときに unlet されるはず。
function! s:SkkInCompletion()
  return exists("b:skk_comp_key")
endfunction

function! s:SkkGetCompKey(key)
  return "^" . a:key . "[^ ]"
endfunction

function! s:SkkCompletion(first)
  if a:first
    let kana = s:SkkCleanRom()
    let line = s:SkkGetLine(".")
    let hstart = b:skk_hstart + strlen(g:skk_marker_white) - 1
    let b:skk_comp_key = strpart(line, hstart, s:SkkCursorCol() - hstart - 1) . kana
    if b:skk_mode == 'kata'
      let b:skk_comp_key = s:SkkKata2Hira(b:skk_comp_key)
    endif
  endif
  let comp = s:SkkCompSearch(a:first, b:skk_comp_key, "W")
  if comp == ""
    return ''
  endif
  call s:SkkEraseYomi()
  return g:skk_marker_white . comp
endfunction

function! s:SkkPrevComp()
  let comp = s:SkkCompSearch(0, b:skk_comp_key, "bW")
  if comp == ""
    return ''
  endif
  call s:SkkEraseYomi()
  return g:skk_marker_white . comp
endfunction

function! s:SkkCompSearch(first, key, flag)
  let buf = s:SkkGetJisyoBuf("skk_jisyo")
  let kata = b:skk_mode == 'kata'
  let cmd = s:SkkShowBuf(buf)
  try
    if a:first
      exe "normal! " . b:skk_okuri_nasi_line . "G$"
    endif
    let lnum = search(s:SkkGetCompKey(a:key), a:flag)
    if lnum <= b:skk_okuri_nasi_line
      return ""
    else
      if kata
        return s:SkkHira2Kata(substitute(getline(lnum), ' .*', '', ''))
      else
        return substitute(getline(lnum), ' .*', '', '')
      endif
    endif
  finally
    exe cmd
  endtry
endfunction

" }}}

" numeric conversion {{{

" 数字変換用に数字の連なりを保存して一つの # に変える。
function! s:SkkGetNumHenkanKey(key)
  let num = '[0-9]\+'
  let key = a:key
  let key = substitute(key, "０", "0", "g")
  let key = substitute(key, "１", "1", "g")
  let key = substitute(key, "２", "2", "g")
  let key = substitute(key, "３", "3", "g")
  let key = substitute(key, "４", "4", "g")
  let key = substitute(key, "５", "5", "g")
  let key = substitute(key, "６", "6", "g")
  let key = substitute(key, "７", "7", "g")
  let key = substitute(key, "８", "8", "g")
  let key = substitute(key, "９", "9", "g")
  let i = 0
  let pos = match(key, num, 0)
  while pos != -1
    let end = matchend(key, num, pos)
    let b:skk_num_list_{i} = strpart(key, pos, end - pos)
    let i= i + 1
    let pos = match(key, num, end)
  endwhile
  let b:skk_num_list_count = i
  let key = substitute(key, num, "#", "g")
  return key
endfunction

function! s:SkkProcessNumCandidate(cand)
  let numexp = '#[0123459]'
  let i = 0
  let pos = match(a:cand, numexp, 0)
  let cand = escape(a:cand, '"\|')
  let args = "\"" . cand . "\", \"" . cand . "\""
  while pos != -1
    let num = a:cand[pos + 1]
    let elem = s:SkkNum{num}(b:skk_num_list_{i})
    if elem == ""
      return
    endif
    let args = args . ", \"" . escape(elem, '"\|') . "\""
    let pos = match(a:cand, numexp, pos + 1)
    let i = i + 1
  endwhile
  exe "call s:SkkAllCombination(" . args . ")"
endfunction

" 第3引数がなくなるまで再帰的に呼び出して組み合わせを作り
" 第3引数がなくなった時点で登録する。
function! s:SkkAllCombination(cand, combi, ...)
  if a:0 == 0
    call s:SkkAddCand(a:cand, a:combi, b:skk_cand_count)
    return
  endif
  let numexp = '#[0123459]'
  let list = a:1
  let args = ""
  let i = 2
  while i <= a:0
    let args = args . ', "' . a:{i} . '"'
    let i = i + 1
  endwhile
  if list[0] != "/"
    " 候補は一つだけ
    let combi = substitute(a:combi, numexp, list, "")
    exe 'call s:SkkAllCombination("' . a:cand . '", "' . combi . '"' . args . ')'
  else
    " 候補は複数ある。
    let sla1 = match(list, '/', 0)
    let sla2 = match(list, '/', sla1 + 1)
    while sla2 != -1
      let elem = strpart(list, sla1 + 1, sla2 - sla1 - 1)
      let combi = substitute(a:combi, numexp, elem, "")
      exe 'call s:SkkAllCombination("' . a:cand . '", "' . combi . '"' . args . ')'
      let sla1 = sla2
      let sla2 = match(list, '/', sla1 + 1)
    endwhile
  endif
endfunction

let s:skk_num_type1 = "0０1１2２3３4４5５6６7７8８9９"
let s:skk_num_type2 = "0〇1一2二3三4四5五6六7七8八9九"
let s:skk_num_type3 = s:skk_num_type2 . "10十100百1000千10000万100000000億1000000000000兆10000000000000000京"
let s:skk_num_type5 = "0零1壱2弐3参4四5伍6六7七8八9九10拾100百1000阡10000萬100000000億1000000000000兆10000000000000000京"

" num に対応する漢字一文字を返す。
function! s:SkkGetNumKanji(num, type)
  let pos = stridx(s:skk_num_type{a:type}, a:num)
  if pos == -1
    return ""
  endif
  let pos = pos + strlen(a:num)
  return matchstr(s:skk_num_type{a:type}, ".", pos)
endfunction

" type の形式に従って num を位取り漢字に変換する。conv1は`1'を変換するか？
function! s:SkkNum2Kanji(num, type, conv1)
  " 後ろから4桁ずつ処理していく。
  let pos = strlen(a:num) - 4
  let tail = strpart(a:num, pos)
  let result = ""
  let base = 1
  while tail != ""
    if tail != 0
      let len = strlen(tail)
      if base != 1
        let basestr = s:SkkGetNumKanji(base, a:type)
        if basestr == ""
          " 未知の桁数に突入した!
          return ""
        endif
        let result = basestr . result
      endif
      " 一の位
      let i = tail[len - 1]
      if i != 0
        let result = s:SkkGetNumKanji(i, a:type) . result
      endif
      " 十の位
      let i = tail[len - 2]
      if i != 0
        let result = s:SkkGetNumKanji(10, a:type) . result
        if i != 1 || a:conv1
          let result = s:SkkGetNumKanji(i, a:type) . result
        endif
      endif
      " 百の位
      let i = tail[len - 3]
      if i != 0
        let result = s:SkkGetNumKanji(100, a:type) . result
        if i != 1 || a:conv1
          let result = s:SkkGetNumKanji(i, a:type) . result
        endif
      endif
      " 千の位
      let i = tail[len - 4]
      if i != 0
        let result = s:SkkGetNumKanji(1000, a:type) . result
        if i != 1 || a:conv1 || (tail == 1000 && base != 1) " 一千万 一千億 ...
          let result = s:SkkGetNumKanji(i, a:type) . result
        endif
      endif
    endif
    let base = base . "0000"
    let pos = pos - 4
    if pos < 0
      let tail = strpart(a:num, 0, pos + 4)
    else
      let tail = strpart(a:num, pos, 4)
    endif
  endwhile
  return result == "" ? s:SkkGetNumKanji(0, a:type) : result
endfunction

" タイプ0 無変換
function! s:SkkNum0(num)
  return a:num
endfunction

" タイプ1 全角数字
function! s:SkkNum1(num)
  let result = ""
  let i = 0
  while a:num[i] != ""
    let result = result . s:SkkGetNumKanji(a:num[i], 1)
    let i = i + 1
  endwhile
  return result
endfunction

" タイプ2 漢数字で位取りなし
function! s:SkkNum2(num)
  let result = ""
  let i = 0
  while a:num[i] != ""
    let result = result . s:SkkGetNumKanji(a:num[i], 2)
    let i = i + 1
  endwhile
  return result
endfunction

" タイプ3 漢数字で位取りあり
function! s:SkkNum3(num)
  return s:SkkNum2Kanji(a:num, 3, 0)
endfunction

" タイプ4 数値再変換
function! s:SkkNum4(num)
  " TODO この要素で確定したとき辞書登録ができない。
  let saved_key = b:skk_henkan_key
  try
    let b:skk_henkan_key = a:num . " "
    let s1 = s:SkkSearch(0)
    let s2 = s:SkkSearch(1)
    return s:SkkMerge(s1, s2)
  finally
    let b:skk_henkan_key = saved_key
  endtry
endfunction

" タイプ5 小切手や手形の金額記入の際用いられる表記
function! s:SkkNum5(num)
  return s:SkkNum2Kanji(a:num, 5, 1)
endfunction

" タイプ9 将棋の棋譜の入力用
function! s:SkkNum9(num)
  if strlen(a:num) != 2
    return ""
  endif
  return s:SkkNum1(a:num[0]) . s:SkkNum2(a:num[1])
endfunction

" }}}

" Face {{{

function! s:SkkFaceOn(cand)
  if g:skk_use_face == 0 || s:skk_in_cmdline
    return
  endif
  try
    let lc = strlen(substitute(a:cand, "[^\n\r]", "", "g"))
    if lc == 0
      let l = b:skk_line
      let sc = b:skk_hstart + strlen(g:skk_marker_black) - 1
      let se = sc + strlen(a:cand) + 1
      exe 'match skk_henkan /\%' . l . 'l\%>' . sc . 'c\%<' . se . 'c./'
    else
      let sl = b:skk_line - 1
      let el = b:skk_line + lc + 1
      if indent(b:skk_line) > 0
        let cand = substitute(a:cand, "[\n\r]", "\n[[:blank:]]*", "g")
      else
        let cand = a:cand
      endif
      exe 'match skk_henkan /\%>' . sl . 'l\%<' . el . 'l' . s:SkkQuoteChar(cand, 1) . '/'
    endif
  catch /^Vim(match):E28:/
    let g:skk_use_face = 0
  endtry
endfunction

function! s:SkkFaceOff()
  if g:skk_use_face == 0 || s:skk_in_cmdline
    return
  endif
  match none
endfunction

" }}}

" auto fill {{{

function! s:SkkDoAutoFill()
  if !exists("g:format_allow_over_tw")
    let b:skk_autofill = 0
    return
  endif
  if &tw == 0
    let tw = 76
  else
    let tw = &tw
  endif
  if virtcol(".") < tw + g:format_allow_over_tw
    return
  endif
  let line = line(".")
  let str = getline(line)
  " 新しく入る文字の場所を "x" で確保しておく。
  let trail = "x" . strpart(str, col(".") - 1)
  call setline(line, strpart(str, 0, col(".") - 1) . trail)
  let lcount = line("$")
  let &l:formatoptions = b:skk_fo_save
  exe "normal " . g:format_command . "gq"
  setlocal fo=
  set backspace=start
  let lcount = line("$") - lcount
  let i = strlen(trail) - 1
  while lcount >= 0
    let str = getline(line + lcount)
    let j = strlen(str) - 1
    while i >= 0 && trail[i] =~ '\s' && trail[i] != str[j]
      let i = i - 1
    endwhile
    while j >= 0 && i >= 0 && trail[i] == str[j]
      let i = i - 1
      let j = j - 1
    endwhile
    if i < 0
      " j は "x" の1文字前を指している。
      call setline(line + lcount, strpart(str, 0, j + 1) . strpart(str, j + 2))
      call cursor(line + lcount, j + 2)
      return
    endif
    let lcount = lcount - 1
  endwhile
  throw "SKK: I couldn't find where I was."
endfunction

" }}}

" RULES section {{{

function! s:SkkAppend(line, str)
  call append(a:line, a:str)
  return a:line + 1
endfunction

function! s:SkkConfirm()
  redraw
  let msg = "Do you want to save changes?\ny=(w\|bw) n=(bw!) c=(do nothing)"
  let i = confirm(msg, "&yes\n&no\n&cancel")
  if i == 1
    w | bw
  elseif i == 2
    bw!
  endif
endfunction

function! s:SkkRulesTraverse(v, line)
  let line = a:line
  if exists("s:skk_rules_{a:v}")
    let line = s:SkkAppend(line, 'let s:skk_rules_' . a:v . ' = "' . escape(s:skk_rules_{a:v}, '"\|') . '"')
  endif
  if exists('s:skk_rules_{a:v}_rest')
    let line = s:SkkAppend(line, 'let s:skk_rules_' . a:v . '_rest = "' . escape(s:skk_rules_{a:v}_rest, '"\|') . '"')
  endif
  if exists('s:skk_rules_{a:v}_func')
    let line = s:SkkAppend(line, 'let s:skk_rules_' . a:v . '_func = "' . escape(s:skk_rules_{a:v}_func, '"\|') . '"')
  endif
  if exists('s:skk_rules_{a:v}_child')
    let line = s:SkkAppend(line, 'let s:skk_rules_' . a:v . '_child = "' . escape(s:skk_rules_{a:v}_child, '"\|') . '"')
    let i = 0
    while s:skk_rules_{a:v}_child[i] != ''
      let line = s:SkkRulesTraverse(a:v . s:ValidVarChar(s:skk_rules_{a:v}_child[i]), line)
      let i = i + 1
    endwhile
  endif
  return line
endfunction

function! s:SkkAppendRules(line)
  if s:skk_rule_compiled == 0
    call SkkRuleCompile()
  endif
  let line = a:line
  let i = char2nr(" ")
  let tilde = char2nr("~")
  while i <= tilde
    if exists('s:skk_zenei_rules_{i}')
      let line = s:SkkAppend(line, 'let s:skk_zenei_rules_' . i . ' = "' . escape(s:skk_zenei_rules_{i}, '"\|') . '"')
    endif
    let v = s:ValidVarChar(nr2char(i))
    let line = s:SkkRulesTraverse(v, line)
    let i = i + 1
  endwhile
  return line
endfunction

" RULES を削除する。
function! SkkDeleteRulesSection()
  if filewritable(s:thisfile) != 1
    call s:SkkEcho("SKK: " . s:thisfile . " cannot be written.", "ErrorMsg", 0)
    return
  endif
  exe "split " . s:thisfile
  normal! gg
  let start = search('^"=== RULES START ===$', 'bw')
  let end = search('^"=== RULES END ===$', "W")
  if (start == 0) || (end == 0)
    bwipeout
    call s:SkkEcho("SKK: cannot find RULES section.", "ErrorMsg", 0)
    return
  endif
  normal! zv
  if getline(start - 1) == ""
    let start = start - 1
  endif
  exe start . "," . end . "d"
  normal! z.
  call s:SkkConfirm()
endfunction

" この関数の後ろに RULES を書き込む。
function! SkkAddRulesSection()
  if filewritable(s:thisfile) != 1
    call s:SkkEcho("SKK: " . s:thisfile . " cannot be written.", "ErrorMsg", 0)
    return
  endif
  exe "split " . s:thisfile
  normal! gg
  if search('^"=== RULES START ===$', "bw") != 0
    normal! zv
    call s:SkkEcho("SKK: RULES section already exists.", "ErrorMsg", 0)
    return
  endif
  if search('^function! SkkAddRulesSection()', "bw") == 0 || search('^endfunction$', "W") == 0
    call s:SkkEcho("SKK: cannot find insert point.", "ErrorMsg", 0)
    return
  endif
  let line = line(".")
  let line = s:SkkAppend(line, "")
  let line = s:SkkAppend(line, '"=== RULES START ===')
  let line = s:SkkAppendRules(line)
  let line = s:SkkAppend(line, "let s:skk_rule_compiled = 1")
  let line = s:SkkAppend(line, "unlet! g:skk_rom_kana_rules")
  let line = s:SkkAppend(line, "unlet! g:skk_rom_func_rules")
  let line = s:SkkAppend(line, "unlet! g:skk_zenei_rules")
  let line = s:SkkAppend(line, '"=== RULES END ===')
  normal! zvz.
  call s:SkkConfirm()
endfunction

" }}}

let &cpo = s:cpo_save

" for DEBUG {{{

if exists("skk_debug")

  function! SearchTest()
    " カレントバッファは "^ぱたーん ", 0 のような行だけでできている必要がある。
    let buf = bufnr("%")
    let i = 1
    let lastline = line("$")
    while i <= lastline
      let str{i} = getline(i)
      let i = i + 1
    endwhile
    if v:version < 700
      exe s:SkkGetJisyoBuf("skk_large_jisyo") . "buffer"
      let arg = ""
    else
      let list = s:SkkGetJisyoBuf("skk_large_jisyo")
      let arg = "list,"
    endif
    let i = 1
    let before = v:version < 700 ? localtime() : reltime()
    while i <= lastline
      exe "call SkkSearchLinear(" . arg  . str{i} . ")"
      let i = i + 1
    endwhile
    let elapsed = v:version < 700 ? localtime() - before : reltimestr(reltime(before))
    let msg = "SearchLinear: " . elapsed . "sec. "
    let i = 1
    let before = v:version < 700 ? localtime() : reltime()
    while i <= lastline
      exe "call SkkSearchBinary(" . arg  . str{i} . ",1000)"
      let i = i + 1
    endwhile
    let elapsed = v:version < 700 ? localtime() - before : reltimestr(reltime(before))
    let msg = msg . "SearchBinary: " . elapsed . "sec. "
    exe buf . "buffer"
    call confirm(msg)
  endfunction

  function! SearchLimitTest(...)
    " カレントバッファは "^ぱたーん ", 0 のような行だけでできている必要がある。
    let buf = bufnr("%")
    let i = 1
    let lastline = line("$")
    while i <= lastline
      let str{i} = getline(i)
      let i = i + 1
    endwhile
    if v:version < 700
      exe s:SkkGetJisyoBuf("skk_large_jisyo") . "buffer"
      let arg = ""
    else
      let list = s:SkkGetJisyoBuf("skk_large_jisyo")
      let arg = "list,"
    endif
    let j = 1
    let msg = ''
    while j <= a:0
      let before = v:version < 700 ? localtime() : reltime()
      let i = 1
      while i <= lastline
        exe "call SkkSearchBinary(" . arg . str{i} . ", " . a:{j} . ")"
        let i = i + 1
      endwhile
      let elapsed = v:version < 700 ? localtime() - before : reltimestr(reltime(before))
      let msg = msg . a:{j} . ": " . elapsed . "sec. "
      let j = j + 1
    endwhile
    exe buf . "buffer"
    call confirm(msg)
  endfunction

endif

" }}}

if v:version < 700
  finish
endif

" for vim7 {{{
" vim7 の sandbox 対策 (コマンドラインの <C-r>=)
" 辞書をバッファでなくてリストで持つ。
" リストには生のデータを読み込み、検索時にキーを辞書のエンコーディングに
" 変換して探す。

" list を返す。最初の要素に
" [送りありの位置, 送りなしの位置, エンコーディング, 改行コード] を入れる。
function! s:SkkGetJisyoBuf(var)
  if exists("s:{a:var}_list")
    return s:{a:var}_list
  endif
  let fname = expand(g:{a:var})
  let s:{a:var}_ftime = getftime(fname)
  let s:{a:var}_fsize = getfsize(fname)
  let s:{a:var}_modified = 0
  silent! exe "let s:{a:var}_list = readfile('" . fname . "', 'b')"
  if len(s:{a:var}_list) == 0
    " 新規ファイル
    let s:{a:var}_list = [[1, 2, &enc, "unix"], ";; okuri-ari entries." , ";; okuri-nasi entries."]
  else
    if len(s:{a:var}_list) == 1 && stridx(s:{a:var}_list[0], "\<CR>") >= 0
      let s:{a:var}_list = split(s:{a:var}_list[0], "\<CR>")
      let ff = "mac"
    endif
    let ari = index(s:{a:var}_list, ";; okuri-ari entries.") + 1
    let nasi = index(s:{a:var}_list, ";; okuri-nasi entries.") + 1
    let s = string(s:{a:var}_list[ari : ari + 30])
    let enc = s:SkkDetectJisyoEnc(a:var, s:{a:var}_list, s)
    if !exists("l:ff")
      let ff = stridx(s, "\<CR>") < 0 ? "unix" : "dos"
      if ff == "dos"
        let ari = index(s:{a:var}_list, ";; okuri-ari entries.\<CR>") + 1
        let nasi = index(s:{a:var}_list, ";; okuri-nasi entries.\<CR>") + 1
      endif
    endif
    call insert(s:{a:var}_list, [ari, nasi, enc, ff], 0)
  endif
  return s:{a:var}_list
endfunction

function! s:SkkDetectJisyoEnc(var, list, conv_str)
  let jisyo_enc_var = a:var ==# 'skk_jisyo' ? 'g:skk_jisyo_encoding' : 'g:skk_large_jisyo_encoding'
  let jisyo_enc = {jisyo_enc_var}

  if (type(jisyo_enc) == type("") && jisyo_enc ==# 'guess')
  \   || type(jisyo_enc) == type([])
    " あやしい文字コード判定
    let exp = "'[" . s:skk_hiragana . ']\+[a-z]\? '
    for enc in (type(jisyo_enc) == type([]) ?
    \             jisyo_enc : ["euc-jp", "cp932", "iso-2022-jp", "utf-8", &enc])
      if iconv(a:conv_str, enc, &enc) =~ exp
        return enc
      endif
    endfor

    let msg = printf("Failed to detect %s encoding.", jisyo_enc_var)
    call s:SkkEcho(msg, 'ErrorMsg', 1)
  elseif type(jisyo_enc) == type("")
    return jisyo_enc
  else
    let msg = printf("Invalid %s value. Try default value...", jisyo_enc_var)
    call s:SkkEcho(msg, 'WarningMsg', 1)

    let save_val = jisyo_enc
    unlet {jisyo_enc_var}
    let {jisyo_enc_var} = 'guess'
    try
      return s:SkkDetectJisyoEnc(a:var, a:list, a:conv_str)
    finally
      unlet {jisyo_enc_var}
      let {jisyo_enc_var} = save_val
    endtry
  endif
endfunction

function! s:SkkShowBuf(buf)
  return ""
endfunction

function! s:SkkSearchBuf(buf, limit)
  let okuri = strlen(b:skk_okurigana)
  let key = "^" . b:skk_henkan_key
  let enc = a:buf[0][2]
  try
    if &enc != enc
      let key = iconv(key, &enc, enc)
      let l:enc_save = &enc
      set enc=latin1
    endif
    if a:limit == 0
      let str = SkkSearchLinear(a:buf, key, okuri)
    else
      let str = SkkSearchBinary(a:buf, key, okuri, a:limit)
    endif
  finally
    if exists("l:enc_save")
      let &enc = l:enc_save
    endif
  endtry
  return exists("l:enc_save") ? iconv(str, enc, &enc) : str
endfunction

function! SkkSearchLinear(buf, key, okuri)
  if a:okuri
    let i = a:buf[0][0] + 1
  else
    let i = a:buf[0][1] + 1
  endif
  let key = escape(a:key, '$.*\[]') . '\m\C'
  " b:skk_found_lnum は現在のバッファに保存される。
  let b:skk_found_lnum = match(a:buf, key, i)
  return b:skk_found_lnum > 0 ? substitute(get(a:buf, b:skk_found_lnum), key, '', '') : ""
endfunction

function! SkkSearchBinary(buf, key, okuri, limit)
  let ari = a:buf[0][0]
  let nasi = a:buf[0][1]
  let key = strpart(a:key, 1)	" remove ^
  if a:okuri
    let min = ari + 1
    let max = nasi - 1
  else
    let min = nasi + 1
    let max = len(a:buf)
  endif
  while max - min > a:limit
    let mid = (max + min) / 2
    let line = get(a:buf, mid)
    if key >=# line
      if a:okuri
        let max = mid
      else
        let min = mid
      endif
    else
      if a:okuri
        let min = mid
      else
        let max = mid
      endif
    endif
  endwhile
  let key = escape(a:key, '$.*\[]') . '\m\C'
  let idx = match(a:buf, key, min)
  return idx > 0 ? substitute(get(a:buf, idx), key, '', '') : ""
endfunction

function! s:SkkUpdateJisyo(word)
  if a:word == ""
    return
  endif
  let buf = s:SkkGetJisyoBuf("skk_jisyo")
  let key = b:skk_henkan_key
  let okuri= strlen(b:skk_okurigana)
  let line = s:SkkSearchBuf(buf, 0)
  let str = s:SkkMakeNewEntry(key, s:SkkValidCand(a:word), line)
  if b:skk_found_lnum > 0
    call remove(buf, b:skk_found_lnum)
  endif
  let lnum = okuri ? buf[0][0] + 1 : buf[0][1] + 1
  if buf[0][2] != &enc
    let str = iconv(str, &enc, buf[0][2])
  endif
  if buf[0][3] == "dos"
    let str = str . "\<CR>"
  endif
  call insert(buf, str, lnum)
  if okuri && b:skk_found_lnum < 0
    let buf[0][1] += 1
  endif
  let s:skk_jisyo_modified = 1
endfunction

function! s:SkkCompSearch(first, key, flag)
  let buf = s:SkkGetJisyoBuf("skk_jisyo")
  let kata = b:skk_mode == 'kata'
  if a:first
    let b:skk_comp_num = 0
  endif
  if a:flag == "bW"
    let num = b:skk_comp_num - 1
  else
    let num = b:skk_comp_num + 1
  endif
  let key = a:key
  try
    if buf[0][2] != &enc
      let key = iconv(key, &enc, buf[0][2])
      let l:enc_save = &enc
      set enc=latin1
    endif
    let key = escape(key, '$.*\[]')
    let key = s:SkkGetCompKey(key) . '\m\C'
    let lnum = match(buf, key, buf[0][1] + 1, num)
  finally
    if exists("l:enc_save")
      let &enc = l:enc_save
    endif
  endtry
  if lnum < 0 || num == 0
    return ""
  else
    let b:skk_comp_num = num
    let line = buf[lnum]
    if exists("l:enc_save")
      let line = iconv(line, buf[0][2], &enc)
    endif
    let line = substitute(line, ' .*', '', '')
    return kata ? s:SkkHira2Kata(line) : line
  endif
endfunction



" 高速化のため。単純にrepeat()使った方が速いはず。
if exists('*repeat')
  function! s:SkkMakeBS(n)
    return repeat("\<C-h>", a:n)
  endfunction
endif

" }}}
