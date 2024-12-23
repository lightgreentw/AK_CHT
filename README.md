<p align = "center">
<img src="https://github.com/lightgreentw/AK_CHT/blob/main/readmePIC00.png" width=80%>
</p>

# Back to the 1979!
創世紀之父理察蓋瑞特(Richard Garriott)的開山之作 - Akalabeth，無疑是電子遊戲創作標竿，CRPG、迷宮探索(Dungeon Crawl)、Rogue-Like、第一人稱視角遊戲(First-person game)甚至3D建模、即時運算，現代熟知的架構在那時候就已經成形。所以熱愛遊戲、熱愛舊遊戲、熱愛創世紀的大家怎麼能不愛這款經典作品。 

# 中文化阿卡拉貝
某日瀏覽網站時逛到 [Akalabeth: porting from AppleSoft BASIC to GW-Basic](https://nanochess.org/akalabeth.html) 驚見網路同好將原本Akalabeth的AppleBASIC原始碼翻譯成GW-Basic版本，搜尋一下曾經Origin的官方網站有公佈過原始碼，所以後續能被眾多同好延伸各種版本，當下就覺得曾經熟悉的程式語言如果沒有拿來利用，尤其是沒有翻譯成中文版本真的是太可惜了！！  
片頭的畫面靈感來自Vectrex版開頭向量圖，那時候看到就很想自己做一個，沒想到現在就用上了，原始Apple II版的片頭是一個圖片檔，於是利用那張圖片用Basic的繪圖函數臨摹了一張，算是將遊戲裡外的風格都一致了。
<p align = "center">
<img src="https://github.com/lightgreentw/AK_CHT/blob/main/readmePIC01.gif" width=60%>
</p>

## 重新接觸QuickBasic
好險QuickBasic有相容原始Basic的行號程式碼，直接無痛轉成QB版本，看著能在自己熟悉的語言下執行程式超級興奮的，忍不住回頭翻了許多留下來的QB書籍，於是訂出兩個目標，復古的方式以DOS為平台、在DOS下顯示中文。
不過畢竟距離前次觸碰QuickBasic 4.5已經是三十年前了，無論是程式開發的架構，以及孩童時代的認知不一樣，像是隔了一層紗，想碰又碰不太到，但是有賴現代的資源豐富，借助ChatGPT把距離縮的好小，這一切都是科技促成。所以利用QB的特性把有行號程式碼跟自訂函數程式碼直接結合起來，中文顯示的部份是自訂函數，替換掉原有程式碼中呈現文字的部份。  
然而沒過一個禮拜就發現另一個更有趣的工具 [QB64.com](https://qb64.com/) ，完全讓開發進程更加快，相容QB4.5幾乎能把DOS下開發的程式碼直接搬到Windows上執行（還跨平台MacOS和Linux上都能跑），不只跳過DOSBox模擬，還有很多強化開發功能，例如變數應用上記憶體完全超越DOS的限制，但還有一個很重要的問題，也許是必須相容DOS，雙字元字碼或Unicode問題並沒有解決，很可惜開發秀中文字的功能並不能省略。

## 點陣中文
第一個頭痛點就是中文字型檔，倚天中文字型並不是無償使用的，而以前留的QB書籍都是以倚天字型檔做範本，所以必須另尋他路。就算是這個年代人類對點陣字仍然有一定程度的依賴，但不得不說也許是向量字的發達，正體中文點陣字的資源很有限，一直深挖下去，被我找到了BDF/PCF這種在Unix / Linux上 X Window使用的點陣字格式，於是在Linux裡挖到了公眾版本的中文點陣字型檔，順手寫了一個簡易的轉檔工具轉成自己可以用的字型檔。雖然後來才又發現文泉驛有更完整的BDF資源，但我想復古到底，連中文字都想用古早味的字型。
<p align = "center">
<img src="https://github.com/lightgreentw/AK_CHT/blob/main/readmePIC03.png" width=60%>
</p>

## 自訂函數
為了中文字顯示，不得不把Akalabeth原本的320x200解析度改成640x480，而且遊戲中大量使用文字模式的特性顯示文字，所以秀出中文字勢必不能使用原生的Basic函數，在自訂函數方面也參考到以不變動原始遊戲程式碼為原則，可以讓程式更保持原樣，例如直接替換掉原來PRINT函數在螢幕上印出字的功能，我直接用PRINTC的自訂函數來印出中文字。
以下就是顯示中文字所需要的相關自訂函數
```javascript
Type textLayer
    currentRow As Integer
    currentCol As Integer
    blockStartRow As Integer
    blockEndRow As Integer
    blockStartCol As Integer
    blockEndCol As Integer
    colorFore As Integer
    colorBack As Integer
End Type
'定義中文字的虛擬圖層

PrintC (nowLayer As Integer, text As String, hWarp As Integer)
'符合顯示中文的方式取代QB的PRINT函數

LocateC (nowLayer As Integer, row As Integer, col As Integer)
'符合顯示中文的方式取代QB中LOCATE的函數

CenterPrintC (nowLayer As Integer, text As String, hWarp As Integer)
'中文字置中

ScaleText (x As Integer, y As Integer, text As String, fColor As Integer, bColor As Integer, chScale As Integer)
'依比例縮放文字

TabC$ (nowLayer As Integer, needPos As Integer)
'取代TAB函數，因為PRINTC是模擬的所以原TAB無法發揮功能

ScrollBlock (nowLayer As Integer)
'模擬文字模式的螢幕滾動，因為中文是用畫的所以不會像文字一樣滾動

SetScrollBlock (setLayer As Integer, startRow As Integer, endRow As Integer, startCol As Integer, endCol As Integer)
'指定文字滾動的區塊

SetColor (setLayer As Integer, fore As Integer, back As Integer)
'配合虛擬圖層定義文字的前景及背景顏色

LangRes$ (langIndex As String)
'訊息文字資源庫，集中文字訊息方便翻譯
```

## 遊戲操作
為了維持原始遊戲味道，除了提高解析度及為了顯示中文而變更字詞和程式
順序外，其他顯示圖形、遊戲流程等程式碼及參數都與原來一樣沒有變動。但是又為了幫助沒有接觸過阿卡拉貝的朋友們能簡單上手，我增加了很多提示字詞，例如在商店中購買物品時，原文版本的物品都是以英文單字呈現，所以購買時只要按下物品單字的字頭就能採購，但中文的部份就必須在物品中文名稱前面加上提示按鈕字母；又如，在下達\<A>攻擊指令時，原程式就只有丟一句「WHICH WEAPON」，就等待玩家下達接下來的指令，一開始確實有點摸不太著頭緒，後來摸索一陣子才知道是要按最初在商店中購買武器時候所按的武器字頭，於是我就加上了提示訊息「使用武器 \<R>長劍 \<A>斧頭 \<S>盾牌 \<B>弓箭 \<M>護身符」。  
再來，我有在Youtube上看過其他版本裡的地下城出現指南針，於是我也在中文版中時做了方位辨識及樓層提示。最後我還有把連1998的DOS版本都沒有的APPLE II版本遊戲大綱及線上操作說明直接搬過來，更能完整表達遊戲，以期待以上一些提昇操作方便的小小功能讓更多人能接受。
<p align = "center">
<img src="https://github.com/lightgreentw/AK_CHT/blob/main/readmePIC02.png" width=60%>
</p>

|鍵盤按鈕     |戶外               |地下城             |
|:---------:|:-----------------:|:----------------:|
|方向鍵      |東西南北            |前進、左轉右轉、迴轉  |
|S          |人物狀態            |人物狀態            |
|A          |N/A                |攻擊               |
|X          |進入城鎮、宮殿、地下城 |上下爬梯、跳入地洞   |
|空白鍵      |PASS               |PASS              |
|P          |僅保留無實際用途      | 僅保留實際無用     |

**還有一個很重要的提醒，遊戲開始一定要先找Lord British的宮殿，才會有任務提示。

## 程式參數
由於使用了QB64這個超強大的編譯器，連螢幕顯示方式都處理好了，故參數以INI的方式設定。
```
[SETUP]
;全螢幕設定 true=全螢幕 false=視窗顯示
Fullscreen=false

;全螢幕時延展方式呈現 true=畫面延展 false=等比放大
Stretch=false

;全螢幕時的像素影像平滑處理 true=平滑 false=銳利
Smooth=true

;小地圖顯示
Map=false

;字型檔名稱
CHTFont=font_t16.dat
ENGFont=font_a16.dat
```

## 已知問題
由於本人沒有任何遊戲開發的經驗，完全是票友身份，中文顯示的方式是以點陣LED顯示的方式以點繪製出來的，如果程式放到DOS下執行中文顯示很慢，猜測是秀字的方式，QB64不是沒問題，大概是Windows下速度夠快，所以看不來，我認定是我的盲點，期望先進前輩給予指教，謝謝！


# Reference
* Akalabeth: World of Doom created by Richard Garriot (Lord British) 
* QuickBASIC is copyright by Microsoft https://zh.wikipedia.org/zh-tw/QuickBASIC 
* GW-BASIC by Microsoft under MIT license https://zh.wikipedia.org/zh-tw/GW-BASIC 
* QB64 is cross-platform compiler https://qb64.com or https://www.qb64phoenix.com/ 
* 阿卡拉貝GW-BASIC版本 https://nanochess.org/akalabeth.html 
* 阿卡拉貝程式碼解析 https://jtauber.github.io/game-hacking/akalabeth/main_game.html 
* AppleBASIC參考 https://www.landsnail.com/a2ref.htm 
* QuickBASIC參考 https://www.pcjs.org/documents/books/mspl13/basic/qblang/ 
* BDF檔參考 https://en.wikipedia.org/wiki/Glyph_Bitmap_Distribution_Format 
* 字體研究參考 https://github.com/champyen/sango2_tc_patch 
