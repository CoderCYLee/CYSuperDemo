
//
//  CoreBluetoothViewController.m
//  CYSuperDemo
//
//  Created by cyrill on 2018/12/24.
//  Copyright © 2018 Cyrill. All rights reserved.
//

#import "CoreBluetoothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface CoreBluetoothViewController () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;

@end

@implementation CoreBluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Scan" style:UIBarButtonItemStyleDone target:self action:@selector(scan)];
    self.navigationItem.rightBarButtonItem = item;
    
    /**
     第一个参数：代理
     第二个参数：队列（nil为不指定队列，默认为主队列）
     第三个参数：实现状态保存的时候需要用到 eg:@{CBCentralManagerOptionRestoreIdentifierKey:@"centralManagerIdentifier"}
     */
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    // centralManagerDidUpdateState
    
    /*
     第一个参数那里表示扫描带有相关服务的外部设备，例如填写@[[CBUUIDUUIDWithString:@"需要连接的外部设备的服务的UUID"]]，即表示带有需要连接的外部设备的服务的UUID的外部设备，nil表示扫描全部设备；
     
     options处以后细讲，暂时可以写一个@{CBCentralManagerScanOptionAllowDuplicatesKey :@YES}这样的参数，YES表示会让中心设备不断地监听外部设备的消息，NO就是不能。
     [manager scanForPeripheralsWithServices:nil options:nil];
     一旦扫描到外部设备，就会进入协议中的
     - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI
     方法
     */
    
}


#pragma mark - CBCentralManagerDelegate

/*!
 *  @method centralManagerDidUpdateState:
 *
 *  @param central  The central manager whose state has changed.
 *
 *  @discussion     Invoked whenever the central manager's state has been updated. Commands should only be issued when the state is
 *                  <code>CBCentralManagerStatePoweredOn</code>. A state below <code>CBCentralManagerStatePoweredOn</code>
 *                  implies that scanning has stopped and any connected peripherals have been disconnected. If the state moves below
 *                  <code>CBCentralManagerStatePoweredOff</code>, all <code>CBPeripheral</code> objects obtained from this central
 *                  manager become invalid and must be retrieved or discovered again.
 *
 *  @see            state
 *
 */
// 中心设备的蓝牙状态发生变化之后会调用此方法 [必须实现的方法]
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    /*
     // 中心设备状态枚举
     typedef NS_ENUM(NSInteger, CBCentralManagerState) {
     CBCentralManagerStateUnknown = CBManagerStateUnknown,// 蓝牙状态未知
     CBCentralManagerStateResetting = CBManagerStateResetting,
     CBCentralManagerStateUnsupported = CBManagerStateUnsupported, // 不支持蓝牙
     CBCentralManagerStateUnauthorized = CBManagerStateUnauthorized, // 蓝牙未授权
     CBCentralManagerStatePoweredOff = CBManagerStatePoweredOff, // 蓝牙关闭状态
     CBCentralManagerStatePoweredOn = CBManagerStatePoweredOn, // 蓝牙开启状态
     } NS_DEPRECATED(NA, NA, 5_0, 10_0, "Use CBManagerState instead");
     */
    
}

// option
/*!
 *  @method centralManager:willRestoreState:
 *
 *  @param central      The central manager providing this information.
 *  @param dict            A dictionary containing information about <i>central</i> that was preserved by the system at the time the app was terminated.
 *
 *  @discussion            For apps that opt-in to state preservation and restoration, this is the first method invoked when your app is relaunched into
 *                        the background to complete some Bluetooth-related task. Use this method to synchronize your app's state with the state of the
 *                        Bluetooth system.
 *
 *  @seealso            CBCentralManagerRestoredStatePeripheralsKey;
 *  @seealso            CBCentralManagerRestoredStateScanServicesKey;
 *  @seealso            CBCentralManagerRestoredStateScanOptionsKey;
 *
 */
// 应用从后台恢复到前台的时候,会和系统蓝牙进行同步,调用此方法
- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    /*
     CBCentralManagerRestoredStatePeripheralsKey // 返回一个中心设备正在连接的所有外设数组
     CBCentralManagerRestoredStateScanServicesKey // 返回一个中心设备正在扫描的所有服务UUID的数组
     CBCentralManagerRestoredStateScanOptionsKey // 返回一个字典包含正在被使用的外设的扫描选项
     */
}

/*!
 *  @method centralManager:didDiscoverPeripheral:advertisementData:RSSI:
 *
 *  @param central              The central manager providing this update.
 *  @param peripheral           A <code>CBPeripheral</code> object.
 *  @param advertisementData    A dictionary containing any advertisement and scan response data.
 *  @param RSSI                 The current RSSI of <i>peripheral</i>, in dBm. A value of <code>127</code> is reserved and indicates the RSSI
 *                                was not available.
 *
 *  @discussion                 This method is invoked while scanning, upon the discovery of <i>peripheral</i> by <i>central</i>. A discovered peripheral must
 *                              be retained in order to use it; otherwise, it is assumed to not be of interest and will be cleaned up by the central manager. For
 *                              a list of <i>advertisementData</i> keys, see {@link CBAdvertisementDataLocalNameKey} and other similar constants.
 *
 *  @seealso                    CBAdvertisementData.h
 *
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    /*
      在这个方法里，我们可以根据我们获取到的硬件的某些条件进行筛选，然后连接我们需要连接的外部设备，例如连接名字带有A的外部设备：
     if ([peripheral.name hasPrefix:@"A"] ) {
         //连接设备
         [central connectPeripheral:peripheral options:nil];
     }
     */
    
    
    //过滤掉无效的结果
    if (peripheral == nil||peripheral.identifier == nil/*||peripheral.name == nil*/)
    {
        return;
    }
    
    NSString *pername =[NSString stringWithFormat:@"%@",peripheral.name];
    NSLog(@"所有服务****：%@",peripheral.services);
    
    NSLog(@"蓝牙名字：%@  信号强弱：%@",pername,RSSI);
    //连接需要的外围设备
//    [self connectPeripheral:peripheral];
    //将搜索到的设备添加到列表中
//    [self.peripherals addObject:peripheral];
    
//    if (_didDiscoverPeripheralBlock) {
//        _didDiscoverPeripheralBlock(central,peripheral,advertisementData,RSSI);
//    }
    
}

/*!
 *  @method centralManager:didConnectPeripheral:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has connected.
 *
 *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has succeeded.
 *
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    // 上面那个方法执行后，这里是连接成功 获取当前设备的服务和特征
    
    
    // 我们在连接成功的方法中开始扫描外部设备的服务：
    
    // 设置设备代理
    [peripheral setDelegate:self];
    // 大概获取服务和特征
//    [peripheral discoverServices:@[[CBUUID UUIDWithString:SERVICE_UUID]]];
    
    NSLog(@"Peripheral Connected");
    
//    if (_centerManager.isScanning) {
//        [_centerManager stopScan];
//    }
    NSLog(@"Scanning stopped");
    
    /*
     
     发现指定的服务时，外围设备（CBPeripheral你连接的对象）会调用peripheral:didDiscoverServices:其委托对象的方法。
     
     接着就会跳入发现服务的代理方法中去：  - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;
     */
}

/*!
 *  @method centralManager:didFailToConnectPeripheral:error:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has failed to connect.
 *  @param error        The cause of the failure.
 *
 *  @discussion         This method is invoked when a connection initiated by {@link connectPeripheral:options:} has failed to complete. As connection attempts do not
 *                      timeout, the failure of a connection is atypical and usually indicative of a transient issue.
 *
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    // 上面那个方法执行后，这里是连接失败
    
}

/*!
 *  @method centralManager:didDisconnectPeripheral:error:
 *
 *  @param central      The central manager providing this information.
 *  @param peripheral   The <code>CBPeripheral</code> that has disconnected.
 *  @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion         This method is invoked upon the disconnection of a peripheral that was connected by {@link connectPeripheral:options:}. If the disconnection
 *                      was not initiated by {@link cancelPeripheralConnection}, the cause will be detailed in the <i>error</i> parameter. Once this method has been
 *                      called, no more methods will be invoked on <i>peripheral</i>'s <code>CBPeripheralDelegate</code>.
 *
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    
}


#pragma mark - CBPeripheralDelegate

/*!
 *  @method peripheralDidUpdateName:
 *
 *  @param peripheral    The peripheral providing this update.
 *
 *  @discussion            This method is invoked when the @link name @/link of <i>peripheral</i> changes.
 */
- (void)peripheralDidUpdateName:(CBPeripheral *)peripheral NS_AVAILABLE(10_9, 6_0) {
    
}

/*!
 *  @method peripheral:didModifyServices:
 *
 *  @param peripheral            The peripheral providing this update.
 *  @param invalidatedServices    The services that have been invalidated
 *
 *  @discussion            This method is invoked when the @link services @/link of <i>peripheral</i> have been changed.
 *                        At this point, the designated <code>CBService</code> objects have been invalidated.
 *                        Services can be re-discovered via @link discoverServices: @/link.
 */
- (void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices NS_AVAILABLE(10_9, 7_0) {
    
}

/*!
 *  @method peripheralDidUpdateRSSI:error:
 *
 *  @param peripheral    The peripheral providing this update.
 *    @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion            This method returns the result of a @link readRSSI: @/link call.
 *
 *  @deprecated            Use {@link peripheral:didReadRSSI:error:} instead.
 */
//- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(nullable NSError *)error NS_DEPRECATED(10_7, 10_13, 5_0, 8_0) {
//
//}

/*!
 *  @method peripheral:didReadRSSI:error:
 *
 *  @param peripheral    The peripheral providing this update.
 *  @param RSSI            The current RSSI of the link.
 *  @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion            This method returns the result of a @link readRSSI: @/link call.
 */
//- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(nullable NSError *)error NS_AVAILABLE(10_13, 8_0) {
//
//}

/*!
 *  @method peripheral:didDiscoverServices:
 *
 *  @param peripheral    The peripheral providing this information.
 *    @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion            This method returns the result of a @link discoverServices: @/link call. If the service(s) were read successfully, they can be retrieved via
 *                        <i>peripheral</i>'s @link services @/link property.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    
    // 我们在这个方法里面开始扫描服务中的特征
    //  [peripheral discoverCharacteristics:nilforService:service];
    
    if (error) {
        NSLog(@"Error discovering services: %@", [error localizedDescription]);
        return;
    }
    NSLog(@"所有的servicesUUID%@",peripheral.services);
    //遍历所有service
    for (CBService *service in peripheral.services)
    {
        NSLog(@"服务%@",service.UUID);
        //找到你需要的servicesuuid
//        if ([[NSString stringWithFormat:@"%@",service.UUID] isEqualToString:SERVICE_UUID])
//        {
//            // 根据UUID寻找服务中的特征
//            [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:CHARACTERISTIC_UUID]] forService:service];
//        }
    }
    // 当我们扫描到特征的时候，就会跳入发现特征的协议方法里去：- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
}

/*!
 *  @method peripheral:didDiscoverIncludedServicesForService:error:
 *
 *  @param peripheral    The peripheral providing this information.
 *  @param service        The <code>CBService</code> object containing the included services.
 *    @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion            This method returns the result of a @link discoverIncludedServices:forService: @/link call. If the included service(s) were read successfully,
 *                        they can be retrieved via <i>service</i>'s <code>includedServices</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheral:didDiscoverCharacteristicsForService:error:
 *
 *  @param peripheral    The peripheral providing this information.
 *  @param service        The <code>CBService</code> object containing the characteristic(s).
 *    @param error        If an error occurred, the cause of the failure.
 *
 *  @discussion            This method returns the result of a @link discoverCharacteristics:forService: @/link call. If the characteristic(s) were read successfully,
 *                        they can be retrieved via <i>service</i>'s <code>characteristics</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error {
    
    // 扫描到特征之后，我们就可以拿到相应的特征进行读写操作。
//     例如进行读取数据的操作：
    
    /*
     if ([characteristics.UUID.UUIDStringisEqualToString:@"你需要的特征的UUID"]){
         // 读取特征数据
         [peripheral readValueForCharacteristic:characteristics];
     
     }
     
     这就读取了特征包含的相关信息，只要读取就会进入另外一个方法：
     
     - (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError *)error;
     */
    
}

/*!
 *  @method peripheral:didUpdateValueForCharacteristic:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param characteristic    A <code>CBCharacteristic</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method is invoked after a @link readValueForCharacteristic: @/link call, or upon receipt of a notification/indication.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    /*
      在这个方法里，我们就可以拿到我们需要的数据了。进行写的操作是
     [peripheralwriteValue:data类型的数据 forCharacteristic:使用到的特征 type:CBCharacteristicWriteWithResponse];
     
     最后的type类型有两个，分别是CBCharacteristicWriteWithResponse和                                                  CBCharacteristicWriteWithoutResponse；
     
     选择第一个，每往硬件写入一次数据都会进入
     
     - (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(NSError *)error;
     这个方法会告诉我们这次的写入是否成功，但是如果我们不用考虑往硬件写入的数据成功与否的话，选择第二个类型就ok。
     */
}

/*!
 *  @method peripheral:didWriteValueForCharacteristic:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param characteristic    A <code>CBCharacteristic</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a {@link writeValue:forCharacteristic:type:} call, when the <code>CBCharacteristicWriteWithResponse</code> type is used.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    /*
     这个方法会告诉我们这次的写入是否成功
     */
}

/*!
 *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param characteristic    A <code>CBCharacteristic</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a @link setNotifyValue:forCharacteristic: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheral:didDiscoverDescriptorsForCharacteristic:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param characteristic    A <code>CBCharacteristic</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a @link discoverDescriptorsForCharacteristic: @/link call. If the descriptors were read successfully,
 *                            they can be retrieved via <i>characteristic</i>'s <code>descriptors</code> property.
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheral:didUpdateValueForDescriptor:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param descriptor        A <code>CBDescriptor</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a @link readValueForDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheral:didWriteValueForDescriptor:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param descriptor        A <code>CBDescriptor</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a @link writeValue:forDescriptor: @/link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(nullable NSError *)error {
    
}

/*!
 *  @method peripheralIsReadyToSendWriteWithoutResponse:
 *
 *  @param peripheral   The peripheral providing this update.
 *
 *  @discussion         This method is invoked after a failed call to @link writeValue:forCharacteristic:type: @/link, when <i>peripheral</i> is again
 *                      ready to send characteristic value updates.
 *
 */
- (void)peripheralIsReadyToSendWriteWithoutResponse:(CBPeripheral *)peripheral {
    
}

/*!
 *  @method peripheral:didOpenL2CAPChannel:error:
 *
 *  @param peripheral        The peripheral providing this information.
 *  @param channel            A <code>CBL2CAPChannel</code> object.
 *    @param error            If an error occurred, the cause of the failure.
 *
 *  @discussion                This method returns the result of a @link openL2CAPChannel: @link call.
 */
- (void)peripheral:(CBPeripheral *)peripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel *)channel error:(nullable NSError *)error  API_AVAILABLE(ios(11.0)){
    
}

#pragma mark - event response
- (void)scan {
    
    [_manager scanForPeripheralsWithServices:nil options:nil];
    
}

#pragma mark - getters and setters

@end
