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
    [self.toggleButton addGestureRecognizer:pan];
    [self addSubview:self.toggleButton];
}

- (void)handleTogglePan:(UIPanGestureRecognizer *)gesture {
    CGPoint t = [gesture translationInView:self];
    CGPoint c = gesture.view.center;
    c.x = MAX(22, MIN(self.bounds.size.width-22, c.x+t.x));
    c.y = MAX(22, MIN(self.bounds.size.height-22, c.y+t.y));
    gesture.view.center = c;
    [gesture setTranslation:CGPointZero inView:self];
}

- (void)setupMenuContainer {
    CGFloat w = MIN(self.bounds.size.width*0.88, 420);
    CGFloat h = self.bounds.size.height*0.75;
    CGFloat x = (self.bounds.size.width-w)/2;
    CGFloat y = (self.bounds.size.height-h)/2;
    self.menuContainer = [[UIView alloc] initWithFrame:CGRectMake(x,y,w,h)];
    self.menuContainer.backgroundColor = [UIColor colorWithRed:0.08 green:0.08 blue:0.08 alpha:0.97];
    self.menuContainer.layer.cornerRadius = 12;
    self.menuContainer.layer.borderWidth = 1;
    self.menuContainer.layer.borderColor = [UIColor colorWithWhite:0.25 alpha:1.0].CGColor;
    self.menuContainer.clipsToBounds = YES;
    self.menuContainer.hidden = YES;

    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0,0,w,56)];
    header.backgroundColor = [UIColor colorWithRed:0.06 green:0.06 blue:0.06 alpha:1.0];
    UIView *accent = [[UIView alloc] initWithFrame:CGRectMake(0,0,3,56)];
    accent.backgroundColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0];
    [header addSubview:accent];
    UILabel *logo = [[UILabel alloc] initWithFrame:CGRectMake(14,8,200,20)];
    logo.text = @"KURIAN.CF";
    logo.font = [UIFont boldSystemFontOfSize:15];
    logo.textColor = [UIColor whiteColor];
    [header addSubview:logo];
    UILabel *build = [[UILabel alloc] initWithFrame:CGRectMake(14,30,200,14)];
    build.text = @"BUILD v1.4.1";
    build.font = [UIFont systemFontOfSize:11];
    build.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [header addSubview:build];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0,16,w,24)];
    title.text = @"• SKIN CHANGER";
    title.font = [UIFont boldSystemFontOfSize:14];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [header addSubview:title];
    UIPanGestureRecognizer *drag = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMenuDrag:)];
    [header addGestureRecognizer:drag];
    [self.menuContainer addSubview:header];

    self.selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(16,64,w-32,20)];
    self.selectedLabel.text = @"Selected: —";
    self.selectedLabel.font = [UIFont boldSystemFontOfSize:13];
    self.selectedLabel.textColor = [UIColor colorWithRed:0.3 green:1.0 blue:0.4 alpha:1.0];
    [self.menuContainer addSubview:self.selectedLabel];

    self.categorySegment = [[UISegmentedControl alloc] initWithItems:@[@"Knives",@"Primary",@"Pistols",@"Gloves"]];
    self.categorySegment.frame = CGRectMake(12,92,w-24,32);
    self.categorySegment.selectedSegmentIndex = 0;
    self.categorySegment.backgroundColor = [UIColor colorWithWhite:0.15 alpha:1.0];
    [self.categorySegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self.categorySegment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    if (@available(iOS 13.0, *)) {
        self.categorySegment.selectedSegmentTintColor = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:1.0];
    }
    [self.categorySegment addTarget:self action:@selector(categoryChanged:) forControlEvents:UIControlEventValueChanged];
    [self.menuContainer addSubview:self.categorySegment];

    self.weaponPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(12,132,w-24,90)];
    self.weaponPicker.dataSource = self;
    self.weaponPicker.delegate = self;
    self.weaponPicker.backgroundColor = [UIColor colorWithWhite:0.12 alpha:1.0];
    self.weaponPicker.layer.cornerRadius = 8;
    [self.menuContainer addSubview:self.weaponPicker];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 8;
    layout.minimumLineSpacing = 8;
    layout.sectionInset = UIEdgeInsetsMake(8,8,8,8);
    CGFloat cellSize = (w-24-32)/5;
    layout.itemSize = CGSizeMake(cellSize, cellSize+10);
    CGFloat gridY = 232;
    CGFloat gridH = h-gridY-56;
    self.skinGrid = [[UICollectionView alloc] initWithFrame:CGRectMake(12,gridY,w-24,gridH) collectionViewLayout:layout];
    self.skinGrid.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    self.skinGrid.layer.cornerRadius = 8;
    self.skinGrid.dataSource = self;
    self.skinGrid.delegate = self;
    [self.skinGrid registerClass:[SkinCell class] forCellWithReuseIdentifier:@"SkinCell"];
    [self.menuContainer addSubview:self.skinGrid];

    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    closeBtn.frame = CGRectMake(0,h-50,w,50);
    closeBtn.backgroundColor = [UIColor colorWithWhite:0.06 alpha:1.0];
    [closeBtn setTitle:@"CLOSE MENU" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor colorWithWhite:0.6 alpha:1.0] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [closeBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [self.menuContainer addSubview:closeBtn];

    [self addSubview:self.menuContainer];
}

- (void)handleMenuDrag:(UIPanGestureRecognizer *)gesture {
    CGPoint t = [gesture translationInView:self];
    self.menuContainer.center = CGPointMake(self.menuContainer.center.x+t.x, self.menuContainer.center.y+t.y);
    [gesture setTranslation:CGPointZero inView:self];
}

- (void)loadCategory:(WeaponCategory)category {
    _currentCategory = category;
    self.currentWeapons = weaponData()[@(category)];
    _selectedWeaponIndex = 0;
    [self loadSkinsForWeaponAtIndex:0];
    [self.weaponPicker reloadAllComponents];
    [self.weaponPicker selectRow:0 inComponent:0 animated:NO];
}

- (void)loadSkinsForWeaponAtIndex:(NSInteger)index {
    if (index >= (NSInteger)self.currentWeapons.count) return;
    NSString *weapon = self.currentWeapons[index];
    self.currentSkins = skinData()[weapon] ?: @[];
    _selectedSkinIndex = 0;
    [self.skinGrid reloadData];
    self.selectedLabel.text = [NSString stringWithFormat:@"Selected: %@", weapon];
}

- (void)categoryChanged:(UISegmentedControl *)seg {
    [self loadCategory:(WeaponCategory)seg.selectedSegmentIndex];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pv { return 1; }
- (NSInteger)pickerView:(UIPickerView *)pv numberOfRowsInComponent:(NSInteger)c { return self.currentWeapons.count; }
- (UIView *)pickerView:(UIPickerView *)pv viewForRow:(NSInteger)row forComponent:(NSInteger)c reusingView:(UIView *)v {
    UILabel *l = [[UILabel alloc] init];
    l.text = self.currentWeapons[row];
    l.textColor = [UIColor whiteColor];
    l.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    l.textAlignment = NSTextAlignmentCenter;
    return l;
}
- (void)pickerView:(UIPickerView *)pv didSelectRow:(NSInteger)row inComponent:(NSInteger)c {
    _selectedWeaponIndex = row;
    [self loadSkinsForWeaponAtIndex:row];
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)s { return self.currentSkins.count; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)ip {
    SkinCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SkinCell" forIndexPath:ip];
    cell.nameLabel.text = self.currentSkins[ip.row];
    [cell setSelectedState:ip.row == _selectedSkinIndex];
    return cell;
}
- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)ip {
    NSInteger prev = _selectedSkinIndex;
    _selectedSkinIndex = ip.row;
    self.selectedLabel.text = [NSString stringWithFormat:@"Selected: %@", self.currentSkins[ip.row]];
    [cv reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:prev inSection:0], ip]];
    NSLog(@"[SkinChanger] %@ -> %@", self.currentWeapons[_selectedWeaponIndex], self.currentSkins[ip.row]);
}

- (void)show {
    self.menuContainer.hidden = NO;
    self.menuContainer.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{ self.menuContainer.alpha = 1.0; }];
}
- (void)hide {
    [UIView animateWithDuration:0.15 animations:^{ self.menuContainer.alpha = 0; }
     completion:^(BOOL f){ self.menuContainer.hidden = YES; }];
}
- (void)toggle {
    self.menuContainer.hidden ? [self show] : [self hide];
}

// ---- INJECTION ENTRY POINT ----

__attribute__((constructor)) static void initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (!window) window = [UIApplication sharedApplication].windows.firstObject;
        SkinChangerUI *ui = [SkinChangerUI sharedInstance];
        if (ui.superview == nil) {
            ui.frame = window.bounds;
            [window addSubview:ui];
            [window bringSubviewToFront:ui];
        }
    });
}

@end
