# StoryBoardを使わずにViewを扱う方法

## 環境
- Xcode 10.2.1
- Objective-C
- iPhone SE (simulator)

## 手順
1. Single View Applicationでプロジジェクトを新規作成
2. Main.storyboard, LaunchScreen.storyboardの削除
  - 消さなくてもいい？
3. General => Development Info => Main Interfaceを空にする
4. AppDelegate.hを以下のように修正
```objc
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) ViewController *viewController;

@end
```

5. AppDelegate.mを以下のように修正
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[ViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    return YES;

}
```

6. ViewController.mを以下のように修正
```objc
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    CGRect rect = [self.view frame];
    UILabel* label = [[UILabel alloc] initWithFrame:rect];
    label.text = @"Hello View World!";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
}


@end
```

これでStoryBoardを使わずに画面上に「Hello World」と表示される