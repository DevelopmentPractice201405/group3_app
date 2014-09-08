# 担当: 大城 章吾

# tmuxのインストールと画面共有

以下にその手順について纏めました。

##1. ライブラリのインストール
##2. tmuxのインストール方法
##3. 画面共有
* * *
tmuxをbuildする際
./configure が止まってしまう事が多く見受けられました。
メッセージを見ると、ライブラリ（libevent）が無いって言われてるので、
まずはそっちの方からインストールする事から始めました。

##1.**ライブラリのインストール**


###1.1 **ソースをダウンロードする**

<p>$mkdir ~/tmp</p>
<p>$cd ~/tmp</p>
<p>$wget http://downloads.sourceforge.net/project/levent/libevent/libevent-2.0/libevent-2.0.16-stable.tar.gz</p>

###1.2 **ダウンロードしたソースを展開する**

<p>$tar zxvf libevent-2.0.16-stable.tar.gz </p>
<p>$cd libevent-2.0.16-stable</p>

###1.3 **configureしてmakeしてinstallする**

<p>$./configure --prefix=$HOME/opt/libevent</p>
<p>$make && make install</p>

* * *

##2 **tmuxのインストール方法**

###2.1 **ソースをダウンロードする**

<p>$cd ~/tmp</p>
<p>$wget http://downloads.sourceforge.net/project/tmux/tmux/tmux-1.5/tmux-1.5.tar.gz</p>

###2.2 **ダウンロードしたソースを展開**

<p>$tar zxvf tmux-1.5.tar.gz</p>
<p>$cd tmux-1.5</p>

###2.3 **configureする**

<p>$DIR="$HOME/opt/libevent/"<p>
<p>$./configure CFLAGS="-I$DIR/include" LDFLAGS="-L$DIR/lib" --prefix=$HOME/opt/tmux</p>

*インストール先としてhome以下を指定するのに加えて、さっきインストールしたlibeventを使うための指定が必要 以下に表記*

###2.4 **インストールする**

<p>$make</p>
<p>$make install</p>

###2.5 **動作確認**

ちゃんとインストールできたか、試しに動かしてみる。
**ライブラリのパスを明示的に指定しないといけない事に注意が必要**

<p>$env LD_LIBRARY_PATH=~/opt/libevent/lib ~/opt/tmux/bin/tmux</p>

動いていれば成功です。

ただ、このままでは**上記のコマンドを叩かないとtmuxが起動しない**という欠点があります。
「長いコードをわざわざ覚えて打ちたくない！」という方向けにtmuxというコマンドだけで起動するaliasを以下に表記する

<p>alias tmux='env LD_LIBRARY_PATH=~/opt/libevent/lib ~/opt/tmux/bin/tmux'</p>

私はこのailasを.bashrcに追加しました。注意点として**このままでは起動しません。**追加、保存しただけでは反映されません。
**.bashrcに追加した後、. .bashrcコマンドで再起動する必要があります**
これで、tmuxというコマンドを打つだけでtmuxが起動されるようになります。

* * * 

##3. **画面共有**

###3.1 **openssh-serverのインストール**

初めにsshで画面共有をしたいのでsshサーバーをインストールします

<p>$sudo apt-get install openssh-server</p>

###3.2 **画面共有**

Aさんの画面をBさんと共有するとします。
すると、AさんのPCにはopenssh-serverがインストールされている必要があります

####以下AさんのPC

<p>$sudo service ssh start #sshサーバーをを起動する</p>

<p>$tmux -S /tmp/tmux_shared_socket #共有するためのソケットを指定</p>

<p>$ chmod 777 /tmp/tmux_shared_socket #ソケットに誰でもアクセスできるようにする</p>

####以下BさんのPC

<p>$ssh(ユーザ名)@(Aさん端末のIPアドレス) #sshしてAさんのPCにアクセス</p>

####以下AさんのPC

<p>$tmux -S /tmp/tmux_shared_socket attach</p>

<p>これでAさんとBさんの画面共有が出来るようになりました。</p>
*****
##担当:又吉洋平 村上寛明   
herokuのURLを貼っておきましたので確認よろしくお願いします。  
#####herokuURL:<p>https://secure-shore-3202.herokuapp.com/</p>
