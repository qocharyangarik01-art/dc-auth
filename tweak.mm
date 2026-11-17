#import <UIKit/UIKit.h>

// ---- ENUMS ----

typedef NS_ENUM(NSInteger, WeaponCategory) {
    WeaponCategoryKnives = 0,
    WeaponCategoryPrimary,
    WeaponCategoryPistols,
    WeaponCategoryGloves
};

// ---- DATA ----

static NSDictionary *weaponData() {
    return @{
        @(WeaponCategoryKnives): @[@"Karambit", @"M9 Bayonet", @"Butterfly", @"Stiletto", @"Flip Knife", @"Kukri", @"Paracord", @"Shadow Daggers"],
        @(WeaponCategoryPrimary): @[@"M4A1", @"AWP", @"AK47", @"M4A1-S", @"Famas", @"MP9", @"UMP45", @"Galil"],
        @(WeaponCategoryPistols): @[@"Desert Eagle", @"USP-S", @"Glock-18", @"P250", @"Five-SeveN", @"Tec-9"],
        @(WeaponCategoryGloves): @[@"Sport Gloves", @"Moto Gloves", @"Specialist Gloves", @"Driver Gloves", @"Hydra Gloves"]
    };
}

static NSDictionary *skinData() {
    return @{
        @"Karambit": @[@"Fade", @"Doppler", @"Tiger Tooth", @"Marble Fade", @"Crimson Web", @"Slaughter", @"Night", @"Autotronic", @"Gamma Doppler"],
        @"M9 Bayonet": @[@"Fade", @"Doppler", @"Tiger Tooth", @"Marble Fade", @"Crimson Web", @"Slaughter"],
        @"Butterfly": @[@"Fade", @"Doppler", @"Tiger Tooth", @"Marble Fade", @"Crimson Web", @"Autotronic"],
        @"Stiletto": @[@"Fade", @"Doppler", @"Tiger Tooth", @"Crimson Web", @"Slaughter"],
        @"Flip Knife": @[@"Fade", @"Doppler", @"Marble Fade", @"Crimson Web", @"Night"],
        @"Kukri": @[@"Fade", @"Doppler", @"Case Hardened", @"Crimson Web"],
        @"Paracord": @[@"Fade", @"Doppler", @"Forest DDPAT", @"Crimson Web"],
        @"Shadow Daggers": @[@"Fade", @"Doppler", @"Tiger Tooth", @"Marble Fade"],
        @"M4A1": @[@"Howl", @"Asiimov", @"Neo-Noir", @"Mecha Industries", @"Nitro", @"Dragon King", @"Flashback"],
        @"AWP": @[@"Dragon Lore", @"Medusa", @"Asiimov", @"Wildfire", @"Neo-Noir", @"Fade", @"Hyper Beast"],
        @"AK47": @[@"Fire Serpent", @"Wild Lotus", @"Asiimov", @"Neon Rider", @"Vulcan", @"Bloodsport", @"Redline"],
        @"M4A1-S": @[@"Printstream", @"Icarus Fell", @"Hyper Beast", @"Hot Rod", @"Cyrex"],
        @"Famas": @[@"Mecha Industries", @"Commemoration", @"Neural Net"],
        @"MP9": @[@"Hydra", @"Rose Iron", @"Hot Rod"],
        @"UMP45": @[@"Crime Scene", @"Primal Saber", @"Fade"],
        @"Galil": @[@"Cerberus", @"Chatterbox", @"Stone Cold"],
        @"Desert Eagle": @[@"Blaze", @"Code Red", @"Mecha Industries", @"Crimson Web", @"Ocean Drive"],
        @"USP-S": @[@"Printstream", @"Neo-Noir", @"Orion", @"Kill Confirmed"],
        @"Glock-18": @[@"Fade", @"Wasteland Rebel", @"Dragon Tattoo", @"Bullet Queen"],
        @"P250": @[@"See Ya Later", @"Asiimov", @"Nuclear Threat"],
        @"Five-SeveN": @[@"Monkey Business", @"Hyper Beast", @"Flame Test"],
        @"Tec-9": @[@"Fuel Injector", @"Decimator", @"Toxic"],
        @"Sport Gloves": @[@"Pandora's Box", @"Superconductor", @"Vice", @"Amphibious"],
        @"Moto Gloves": @[@"Spearmint", @"POW!", @"Cool Mint", @"Finish Line"],
        @"Specialist Gloves": @[@"Crimson Kimono", @"Fade", @"Emerald Web"],
        @"Driver Gloves": @[@"King Snake", @"Crimson Weave", @"Lunar Weave"],
        @"Hydra Gloves": @[@"Case Hardened", @"Emerald", @"Rattler"]
    };
}

// ---- SKIN CELL ----

@interface SkinCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *selectedIndicator;
- (void)setSelectedState:(BOOL)selected;
@end

@implementation SkinCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1.0];
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.contentView.bounds, 4, 4)];
        self.nameLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:self.nameLabel];
        self.selectedIndicator = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        self.selectedIndicator.layer.borderColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0].CGColor;
        self.selectedIndicator.layer.borderWidth = 2.5;
        self.selectedIndicator.layer.cornerRadius = 8;
        self.selectedIndicator.hidden = YES;
        [self.contentView addSubview:self.selectedIndicator];
    }
    return self;
}
- (void)setSelectedState:(BOOL)selected {
    self.selectedIndicator.hidden = !selected;
    self.contentView.backgroundColor = selected ?
        [UIColor colorWithRed:0.2 green:0.18 blue:0.0 alpha:1.0] :
        [UIColor colorWithWhite:0.15 alpha:1.0];
}
@end

// ---- MAIN UI ----

@interface SkinChangerUI : UIView
<UICollectionViewDataSource, UICollectionViewDelegate,
UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIView *menuContainer;
@property (nonatomic, strong) UIButton *toggleButton;
@property (nonatomic, strong) UISegmentedControl *categorySegment;
@property (nonatomic, strong) UIPickerView *weaponPicker;
@property (nonatomic, strong) UICollectionView *skinGrid;
@property (nonatomic, strong) UILabel *selectedLabel;
@property (nonatomic, assign) WeaponCategory currentCategory;
@property (nonatomic, strong) NSArray *currentWeapons;
@property (nonatomic, strong) NSArray *currentSkins;
@property (nonatomic, assign) NSInteger selectedWeaponIndex;
@property (nonatomic, assign) NSInteger selectedSkinIndex;
+ (instancetype)sharedInstance;
- (void)show;
- (void)hide;
- (void)toggle;
@end

@implementation SkinChangerUI

+ (instancetype)sharedInstance {
    static SkinChangerUI *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SkinChangerUI alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _currentCategory = WeaponCategoryKnives;
        _selectedWeaponIndex = 0;
        _selectedSkinIndex = 0;
        [self setupToggleButton];
        [self setupMenuContainer];
        [self loadCategory:WeaponCategoryKnives];
    }
    return self;
}

- (void)setupToggleButton {
    self.toggleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.toggleButton.frame = CGRectMake(20, 100, 44, 44);
    self.toggleButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.9];
    self.toggleButton.layer.cornerRadius = 22;
    self.toggleButton.layer.borderWidth = 2;
    self.toggleButton.layer.borderColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0].CGColor;
    [self.toggleButton setTitle:@"K" forState:UIControlStateNormal];
    [self.toggleButton setTitleColor:[UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
    self.toggleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.toggleButton addTarget:self action:@selector(toggle) forControlEvents:UIControlEventTouchUpInside];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleTogglePan:)];
    [self
