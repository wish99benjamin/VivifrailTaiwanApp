library my_prj.globals;
import 'package:intl/date_symbol_data_local.dart';

//姓名string 編號int 生日string 性別string 等級int 個人資料照片int
var userList = [];
int grade = 0, profileImageNumber = -1, user_id = -1;
String name = '王小明', birth = '1990-10-25';
bool isMale = true, value = false;
List recordTimeList = [];

bool? completeToday;
List checkList = [];

var _selectedDate = DateTime.now();
String today = "${_selectedDate.year.toString()}-${_selectedDate.month.toString()
                    .padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

//名稱 圖片 語音 影片連結 敘述 次數
List exerciseList = [
                      [
                        //A
                        ['步行',
                          'assets/images/A/步行.png',
                          '',
                          'assets/videos/walkA.mp4',
                          '在旁人或助行器的輔助下，從椅子上起身。開始以自己的步行速度行走5到10秒後，站著休息，再繼續行走，整個過程共重複5次以上。逐漸增加行走時間，直到您可以連續走一到兩分鐘為止。(唯有您的肌力被改善後，才可以開始這項訓練。)',
                          ' ',
                        ],
                        ['擠壓球',
                          'assets/images/A/擠壓球.png',
                          '',
                          'assets/videos/ball.mp4',
                          '拿一顆橡膠球或握力球，盡可能慢慢用力握緊，然後鬆開手。每組12次，做3組，兩組之間休息1分鐘。3組都做完之後，換手再次練習。',
                          '12次 x 3組 x 雙手',
                        ],
                        ['舉水瓶',
                          'assets/images/A/舉水瓶.png',
                          '', 
                          'assets/videos/waterbottle.mp4',
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓練強度。',
                          '12次 x 3組',
                        ],
                        ['腳踝負重的腿部伸展', 
                          'assets/images/A/腳踝負重的腿部伸展.png', 
                          '', 
                          'assets/videos/leg.mp4',
                          '坐在椅子上，在一隻腿的腳踝上放500公克的負重沙包，水平抬起小腿，並盡可能保持筆直。每組12次，做3組，兩組之間休息1分鐘。如果沒有辦法以此重量重複12次，請取下腳踝負重沙包。',
                          '12次 x 3組',
                        ],
                        ['在人員輔助下從椅子起身', 
                          'assets/images/A/在人員輔助下從椅子起身.png', 
                          '', 
                          'none', 
                          '坐在穩固的椅子上，輔助人員在您的前方伸出雙手，腳踩著地板，抓穩輔助人員的手臂站起身來。起身後站立1秒，然後再抓穩輔助人員的手坐下。每組12次，做3組，兩組之間休息1分鐘。',
                          '12次 x 3組',
                        ],
                        ['直線走路', 
                          'assets/images/A/直線走路.png', 
                          '', 
                          'assets/videos/walk_straight.mp4', 
                          '在桌子、牆壁或家人旁起身站立。一腳腳跟觸碰另一腳腳尖。以直線方式小步走，後腳腳尖剛好抵住前腳的腳跟。每組15步，走3組，兩組之間休息30秒。',
                          '15步 x 3組',
                        ],
                        ['往上伸展手臂', 
                          'assets/images/A/往上伸展手臂.png', 
                          '', 
                          'assets/videos/arms.mp4 ', 
                          '可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢10到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                      ],
                      [
                        //B
                        ['步行', 
                          'assets/images/B/步行.png', 
                          '', 
                          'assets/videos/walk.mp4', 
                          '面向前方，以能夠讓您保持和旁人對話，但感到輕微費力的速度步行，不要低頭看地面。步行時先踩下腳跟，然後才是腳趾。保持肩膀放鬆，手臂輕微擺動。每組2至5分鐘，做5組，兩組之間休息1分鐘。全部做完時，慢走2分鐘作為緩和。在第7周以後，每組8分鐘，做3組，兩組之間休息1分鐘。全部做完時，慢走2分鐘作為緩和。',
                          ' ',
                        ],
                        ['舉水瓶', 
                          'assets/images/B/舉水瓶.png', 
                          '', 
                          'assets/videos/waterbottle.mp4',
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓練強度。',
                          '12次 x 3組',
                        ],
                        ['擠壓球', 
                          'assets/images/B/擠壓球.png', 
                          '', 
                          'assets/videos/ball.mp4', 
                          '拿一顆橡膠球或握力球，盡可能慢慢用力握緊，然後鬆開手。每組12次，做3組，兩組之間休息一分鐘。3組都做完之後，換手再次練習。',
                          '12次 x 3組',
                        ],
                        ['模擬坐下動作', 
                          'assets/images/B/模擬坐下動作.png', 
                          '', 
                          'assets/videos/sitdown.mp4', 
                          '站在一張桌子前，開始慢慢屈膝把臀部放低，好像要坐下一樣，然後回到站立的姿勢。每組12次，總共做3組，兩組之間休息一分鐘。為了確保安全，請在身後放一張椅子。',
                          '12次 x 3組',
                        ],
                        ['用腳尖和腳跟走路', 
                          'assets/images/B/用腳尖和腳跟走路.png', 
                          '', 
                          'assets/videos/tiptoe.mp4', 
                          '站起來，然後扶著桌子邊緣或扶手支撐身體。只用腳尖支撐身體重量，然後踮腳走7步。休息一下，換用腳跟支撐再走7步。每組14步，總共做3組，兩組之間休息一分鐘。可改變手臂的姿勢，例如：將手交叉在胸前或者往前伸直交叉。如果旁邊有人協助，可以閉上眼睛練習。',
                          '14步 x 3組',
                        ],
                        ['椅上伸展手臂', 
                          'assets/images/B/椅上伸展手臂.png', 
                          '', 
                          'none', 
                          '找一張有椅背的椅子，坐在椅子上，身體遠離椅背，雙手自然垂在身體兩側，然後把手臂往後伸，試著抓住椅背。維持這個姿勢把胸往前挺，直到手臂肌肉感覺有點緊繃，並保持這個姿勢10秒，接著放鬆5秒，此時手不要從椅背上移開。每組3次，總共做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                        ['往上伸展手臂', 
                          'assets/images/B/往上伸展手臂.png', 
                          '', 
                          'assets/videos/arms.mp4 ', 
                          '您可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢時到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                      ],
                      [
                        //B
                        ['步行',
                          'assets/images/B/步行.png',
                          '',
                          'assets/videos/walk.mp4',
                          '面向前方，以能夠讓您保持和旁人對話，但感到輕微費力的速度步行，不要低頭看地面。步行時先踩下腳跟，然後才是腳趾。保持肩膀放鬆，手臂輕微擺動。每組2至5分鐘，做5組，兩組之間休息1分鐘。全部做完時，慢走2分鐘作為緩和。在第7周以後，每組8分鐘，做3組，兩組之間休息1分鐘。全部做完時，慢走2分鐘作為緩和。',
                          ' ',
                        ],
                        ['舉水瓶',
                          'assets/images/B/舉水瓶.png',
                          '',
                          'assets/videos/waterbottle.mp4',
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓練強度。',
                          '12次 x 3組',
                        ],
                        ['擠壓球',
                          'assets/images/B/擠壓球.png',
                          '',
                          'assets/videos/ball.mp4',
                          '拿一顆橡膠球或握力球，盡可能慢慢用力握緊，然後鬆開手。每組12次，做3組，兩組之間休息一分鐘。3組都做完之後，換手再次練習。',
                          '12次 x 3組',
                        ],
                        ['模擬坐下動作',
                          'assets/images/B/模擬坐下動作.png',
                          '',
                          'assets/videos/sitdown.mp4',
                          '站在一張桌子前，開始慢慢屈膝把臀部放低，好像要坐下一樣，然後回到站立的姿勢。每組12次，總共做3組，兩組之間休息一分鐘。為了確保安全，請在身後放一張椅子。',
                          '12次 x 3組',
                        ],
                        ['用腳尖和腳跟走路',
                          'assets/images/B/用腳尖和腳跟走路.png',
                          '',
                          'assets/videos/tiptoe.mp4',
                          '站起來，然後扶著桌子邊緣或扶手支撐身體。只用腳尖支撐身體重量，然後踮腳走7步。休息一下，換用腳跟支撐再走7步。每組14步，總共做3組，兩組之間休息一分鐘。可改變手臂的姿勢，例如：將手交叉在胸前或者往前伸直交叉。如果旁邊有人協助，可以閉上眼睛練習。',
                          '14步 x 3組',
                        ],
                        ['椅上伸展手臂',
                          'assets/images/B/椅上伸展手臂.png',
                          '',
                          'none',
                          '找一張有椅背的椅子，坐在椅子上，身體遠離椅背，雙手自然垂在身體兩側，然後把手臂往後伸，試著抓住椅背。維持這個姿勢把胸往前挺，直到手臂肌肉感覺有點緊繃，並保持這個姿勢10秒，接著放鬆5秒，此時手不要從椅背上移開。每組3次，總共做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                        ['往上伸展手臂',
                          'assets/images/B/往上伸展手臂.png',
                          '',
                          'assets/videos/arms.mp4 ',
                          '您可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢時到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                      ],
                      [
                        ['步行', 
                          'assets/images/C/步行.png', 
                          '', 
                          'assets/videos/walk.mp4', 
                          '面向前方，以能夠讓您保持和旁人對話，但感到輕微費力的速度步行，不要低頭看地面。步行時先踩下腳跟，然後才是腳趾。保持肩膀放鬆，手臂輕微擺動。每組10分鐘，做3組，兩組之間休息一分鐘。全部做完時，慢走兩分鐘作為緩和。第7周以後，每組15分鐘，做3組，兩組之間休息一分鐘。全部做完時，慢走兩分鐘作為緩和。',
                          ' ',
                        ],
                        ['扭毛巾', 
                          'assets/images/C/扭毛巾.png', 
                          '', 
                          'none', 
                          '拿一條小毛巾，以雙手握住毛巾兩端，然後像擰濕毛巾那樣扭毛巾。盡量用力扭，並持續2-3秒。每組12次，做3組，兩組之間休息1分鐘。',
                          '12次 x 3組',
                        ],
                        ['舉水瓶', 
                          'assets/images/C/舉水瓶.png', 
                          '', 
                          'assets/videos/waterbottle.mp4', 
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓 練強度。',
                          '12次 x 3組',
                        ],
                        ['從椅子起身', 
                          'assets/images/C/從椅子起身.png', 
                          '', 
                          'assets/videos/chair.mp4', 
                          '坐在有扶手的穩固椅子上，腳踩著地板，不依靠椅子扶手自行站起來，站起身後維持1秒再坐下。每組12次，做3組，兩組之間休息1分鐘。請記住，儘管感到有一些費力，做完第一組之後您應能夠繼續重複12次。如果您無法自行完成，可用一隻手臂支撐椅子扶手做輔助站起，如果無法僅用一隻手臂輔助，可用兩隻手同時支撐椅子扶手站起。',
                          '12次 x 3組',
                        ],
                        ['跨越障礙物', 
                          'assets/images/C/跨越障礙物.png', 
                          '', 
                          'assets/videos/obstacle.mp4', 
                          '使用膠帶貼在桌子或扶手旁的地板上，假裝膠帶是障礙物。站在桌子或扶手旁，以放鬆的姿勢朝膠帶處走，然後跨過膠帶，假裝正在跨越15公分高的障礙物，必要時可支撐桌子或扶手進行。每組跨越5次障礙物，做8組，兩組之間休息一分鐘。',
                          '5次 x 8組',
                        ],
                        ['走8字步', 
                          'assets/images/C/走8字步.png', 
                          '', 
                          'assets/videos/walk8.mp4', 
                          '將兩瓶水放在地上，間隔至少一公尺。在瓶子之間走一個8字後，停下並站著休息10秒。每組走2圈，做3組，兩組之間休息1分鐘。可改變手臂的姿勢，例如：將手交叉在胸前或者往前伸直交叉。可換在不同的地面上走，例如：沙地或草地。如果旁邊有人協助，可以閉上眼睛練習。',
                          '2圈 x 3組',
                        ],
                        ['腿部伸展', 
                          'assets/images/C/腿部伸展.png', 
                          '', 
                          'none',
                          '坐在椅子上將一隻腿往前伸直，腳跟放在地板上，雙手放在另一隻彎曲腿的膝蓋上。將抵住地板的腳掌微微往上拉直，並往前移動身體，您應該會感覺後背和大腿後側有點緊，維持這個姿勢10到12秒後休息5秒。兩腿輪流重複6次為1組，做3組，兩組之間休息1分鐘。',
                          '3次 x 雙腳 x 3組',
                        ],
                        ['往上伸展手臂', 
                          'assets/images/C/往上伸展手臂.png', 
                          '', 
                          'assets/videos/arms.mp4 ', 
                          '您可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢10到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息1分鐘。',
                          '3次 x 3組',
                        ],
                      ],
                      [
                        ['步行',
                          'assets/images/C/步行.png',
                          '',
                          'assets/videos/walk.mp4',
                          '面向前方，以能夠讓您保持和旁人對話，但感到輕微費力的速度步行，不要低頭看地面。步行時先踩下腳跟，然後才是腳趾。保持肩膀放鬆，手臂輕微擺動。每組10分鐘，做3組，兩組之間休息一分鐘。全部做完時，慢走兩分鐘作為緩和。第7周以後，每組15分鐘，做3組，兩組之間休息一分鐘。全部做完時，慢走兩分鐘作為緩和。',
                          ' ',
                        ],
                        ['扭毛巾',
                          'assets/images/C/扭毛巾.png',
                          '',
                          'none',
                          '拿一條小毛巾，以雙手握住毛巾兩端，然後像擰濕毛巾那樣扭毛巾。盡量用力扭，並持續2-3秒。每組12次，做3組，兩組之間休息1分鐘。',
                          '12次 x 3組',
                        ],
                        ['舉水瓶',
                          'assets/images/C/舉水瓶.png',
                          '',
                          'assets/videos/waterbottle.mp4',
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓 練強度。',
                          '12次 x 3組',
                        ],
                        ['從椅子起身',
                          'assets/images/C/從椅子起身.png',
                          '',
                          'assets/videos/chair.mp4',
                          '坐在有扶手的穩固椅子上，腳踩著地板，不依靠椅子扶手自行站起來，站起身後維持1秒再坐下。每組12次，做3組，兩組之間休息1分鐘。請記住，儘管感到有一些費力，做完第一組之後您應能夠繼續重複12次。如果您無法自行完成，可用一隻手臂支撐椅子扶手做輔助站起，如果無法僅用一隻手臂輔助，可用兩隻手同時支撐椅子扶手站起。',
                          '12次 x 3組',
                        ],
                        ['跨越障礙物',
                          'assets/images/C/跨越障礙物.png',
                          '',
                          'assets/videos/obstacle.mp4',
                          '使用膠帶貼在桌子或扶手旁的地板上，假裝膠帶是障礙物。站在桌子或扶手旁，以放鬆的姿勢朝膠帶處走，然後跨過膠帶，假裝正在跨越15公分高的障礙物，必要時可支撐桌子或扶手進行。每組跨越5次障礙物，做8組，兩組之間休息一分鐘。',
                          '5次 x 8組',
                        ],
                        ['走8字步',
                          'assets/images/C/走8字步.png',
                          '',
                          'assets/videos/walk8.mp4',
                          '將兩瓶水放在地上，間隔至少一公尺。在瓶子之間走一個8字後，停下並站著休息10秒。每組走2圈，做3組，兩組之間休息1分鐘。可改變手臂的姿勢，例如：將手交叉在胸前或者往前伸直交叉。可換在不同的地面上走，例如：沙地或草地。如果旁邊有人協助，可以閉上眼睛練習。',
                          '2圈 x 3組',
                        ],
                        ['腿部伸展',
                          'assets/images/C/腿部伸展.png',
                          '',
                          'none',
                          '坐在椅子上將一隻腿往前伸直，腳跟放在地板上，雙手放在另一隻彎曲腿的膝蓋上。將抵住地板的腳掌微微往上拉直，並往前移動身體，您應該會感覺後背和大腿後側有點緊，維持這個姿勢10到12秒後休息5秒。兩腿輪流重複6次為1組，做3組，兩組之間休息1分鐘。',
                          '3次 x 雙腳 x 3組',
                        ],
                        ['往上伸展手臂',
                          'assets/images/C/往上伸展手臂.png',
                          '',
                          'assets/videos/arms.mp4 ',
                          '您可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢10到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息1分鐘。',
                          '3次 x 3組',
                        ],
                      ],
                      [
                        ['步行', 
                          'assets/images/D/步行.png', 
                          '', 
                          'assets/videos/walk.mp4', 
                          '面向前方步行，不要低頭看地面。先踩下腳跟，然後才是腳趾。保持肩膀放鬆，手臂輕微擺動。每組步行20分鐘，做2組，兩組之間休息1分鐘。全部做完時，慢走2分鐘作為緩和。步行的速度以能夠讓您保持和旁人對話，但感到輕微費力為主。自第7週起，持續走30到45分鐘。',
                          ' ',
                        ],
                        ['扭毛巾', 
                          'assets/images/D/扭毛巾.png', 
                          '', 
                          'none', 
                          '以雙手握住毛巾兩端，然後就像擰一條濕毛巾那樣扭毛巾。緩慢但盡量用力扭，並持續2到3秒。每組12次，做3組，兩組之間休息1分鐘。',
                          '12次 x 3組',
                        ],
                        ['舉水瓶', 
                          'assets/images/D/舉水瓶.png', 
                          '', 
                          'assets/videos/waterbottle.mp4', 
                          '拿兩個裝滿水的塑膠瓶。坐下時雙手自然垂在身體兩側，兩手各握住一支水瓶。把手肘朝胸口的方向彎曲，將瓶子舉到與肩膀齊高。每組 12 次，總共做 3 組，兩組之間休息 1 分鐘。請記住，調整水瓶的重量讓您可再度重複這個動作 12次，同時感受到有一點費力。如果發現自己無法做完 3 組，請把瓶內的水倒掉一些。如果您能夠很輕鬆地完成 3 組，請增加瓶子內的水量或者使用更大容量的瓶子。這項訓練進行 6 週後，請稍微增加瓶子內的水以提高訓 練強度。',
                          '12次 x 3組',
                        ],
                        ['從椅子起身', 
                          'assets/images/D/從椅子起身.png', 
                          '', 
                          'assets/videos/chair.mp4', 
                          '坐在有扶手的穩固椅子上，腳踩著地板，不依靠椅子扶手自行站起來，站起身後維持 1秒再坐下。每組12次，做3組，兩組之間休息1分鐘。請記住，儘管感到有一些費力，做完第一組之後您應能夠繼續重複12次。如果您無法自行完成，可用一隻手臂支撐椅子扶手做輔助站起，如果無法僅用一隻手臂輔助，可用兩隻手同時支撐椅子扶手站起。',
                          '12次 x 3組',
                        ],
                        ['上下樓梯', 
                          'assets/images/D/上下樓梯.png', 
                          '', 
                          'none', 
                          '先從扶著扶手上下樓梯開始，如果有信心的話可以不用扶手，或是一次踏兩階。每組走20步，做3組，兩組之間休息1分鐘。',
                          '20步 x 3組',
                        ],
                        ['邊拍汽球邊走路', 
                          'assets/images/D/邊拍汽球邊走路.png', 
                          '', 
                          'none', 
                          '直線向前走，同時氣球在左右兩手間互相拍打。每組走10步，做3組，兩組之間休息30秒。',
                          '10步 x 3組',
                        ],
                        ['走8字步', 
                          'assets/images/D/走8字步.png', 
                          '', 
                          'assets/videos/walk8.mp4', 
                          '將兩瓶水放在地上，間隔至少一公尺。在瓶子之間走一個8字後，停下並站著休息10秒。每組走2圈，做3組，兩組之間休息1分鐘。可改變手臂的姿勢，例如：將手交叉在胸前或者往前伸直交叉。可換在不同的地面上走，例如：沙地或草地。如果旁邊有人協助，可以閉上眼睛練習。',
                          '2圈 x 3組',
                        ],
                        ['腿部伸展', 
                          'assets/images/D/腿部伸展.png', 
                          '', 
                          'none', 
                          '坐在椅子上將一隻腿往前伸直，腳跟放在地板上，雙手放在另一隻彎曲腿的膝蓋上。將抵住地板的腳掌微微往上拉直，並往前移動身體，您應該會感覺後背和大腿後側有點緊，維持這個姿勢10到12秒後休息5秒。兩腿輪流重複6次為1組，做3組，兩組之間休息30秒。',
                          '3次 x 雙腳 x 3組',
                        ],
                        ['往上伸展手臂', 
                          'assets/images/D/往上伸展手臂.png', 
                          '', 
                          'assets/videos/arms.mp4 ', 
                          '您可以站著或坐著進行這項訓練。雙手互扣並把手臂向上拉直，好像要觸摸天花板一樣。維持這個姿勢10到12秒，然後暫停並放鬆手臂5秒。每組3次，做3組，兩組之間休息30秒。',
                          '3次 x 3組',
                        ],
                      ],
                    ];

void setUp(){
  print("Hello");
  print(userList);
  var temp = userList[0][0].split(" ");
  name = temp[0];
  user_id = int.parse(temp[1]);
  birth = temp[2];
  if(temp[3] == "male"){
    isMale = true;
  }
  else{
    isMale = false;
  }
  grade = int.parse(temp[4]);
  profileImageNumber = int.parse(temp[5]);

  if(temp.length >= 6){
    if(temp[6] == today){
      for(int i = 7; i < temp.length; i ++){
        checkList.add(int.parse(temp[i]));
      }
    }
  }
  print(checkList);
}               

void writeBack(){
  var temp = "";
  temp += name + " ";
  temp += (user_id.toString()) + " ";
  temp += birth + " ";
  if(isMale = true){
    temp += "male ";
  }
  else{
    temp += "female ";
  }
  temp += grade.toString() + " ";
  temp += profileImageNumber.toString() + " ";
  if(userList.isEmpty){
    userList.add([temp]);
  }
  else{
    userList[0][0] = temp;
  }

  if(checkList.isNotEmpty) {
    temp = "";
    temp += today + " ";
    for (int i = 0; i < checkList.length; i ++) {
      temp += checkList[i].toString() + " ";
    }
    userList[0][0] += temp;
  }
  print(userList);
}