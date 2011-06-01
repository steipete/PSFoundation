@interface NSDictionary (CGStructs)

- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key;

@end

@interface NSMutableDictionary (CGStructs)

- (void)setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)setSize:(CGSize)value forKey:(NSString *)key;
- (void)setRect:(CGRect)value forKey:(NSString *)key;

@end
