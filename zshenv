#####################################################################
#
#  Sample .zshenv file
#
#  initial setup file for both interactive and noninteractive zsh
#
#####################################################################

limit coredumpsize 0
# Setup command search path
typeset -U path
# (N-/) ���դ��뤳�Ȥ�¸�ߤ��ʤ����̵�뤷�Ƥ����
path=($path /usr/*/bin(N-/) /usr/local/*/bin(N-/) /var/*/bin(N-/))

# ��⡼�Ȥ��鵯ư���륳�ޥ���ѤδĶ��ѿ�������(ɬ�פʤ�)
export RSYNC_RSH=ssh
export CVS_RSH=ssh
