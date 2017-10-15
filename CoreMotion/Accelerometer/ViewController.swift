import CoreMotion
import UIKit
class ViewController: UIViewController {
    var motion = CMMotionManager()
    var timer = Timer()
    
    @IBOutlet weak var gyroHandler: UISwitch!
    @IBOutlet weak var accHandler: UISwitch!
    @IBOutlet weak var gyroZ: UILabel!
    @IBOutlet weak var gyroY: UILabel!
    @IBOutlet weak var gyroX: UILabel!
    @IBOutlet weak var accZ: UILabel!
    @IBOutlet weak var accY: UILabel!
    @IBOutlet weak var accX: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //  startAccelerometers()
      //  startGyros()
    }
    
    
    func startAccelerometers() {
        // Make sure the accelerometer hardware is available.
        if self.motion.isAccelerometerAvailable {
            self.motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
            self.motion.startAccelerometerUpdates()
            
            // Configure a timer to fetch the data.
            self.timer = Timer(fire: Date(), interval: (3.0),
                               repeats: true, block: { (timer) in
                                // Get the accelerometer data.
                                if let data = self.motion.accelerometerData {
                                    let x = data.acceleration.x
                                    let y = data.acceleration.y
                                    let z = data.acceleration.z
                                    
                                    print("Accelerometer X=\(x) Y=\(y) Z=\(z)")
                                    
                                    // Use the accelerometer data in your app.
                                    self.accX.text = String(x)
                                    self.accY.text = String(y)
                                    self.accZ.text = String(z)
                                    
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
}
    
    
    func startGyros() {
        if motion.isGyroAvailable {
            self.motion.gyroUpdateInterval = 3.0
            self.motion.startGyroUpdates()
            
            // Configure a timer to fetch the accelerometer data.
            self.timer = Timer(fire: Date(), interval: (1.0/60.0),
                               repeats: true, block: { (timer) in
                                // Get the gyro data.
                                if let data = self.motion.gyroData {
                                    let x = data.rotationRate.x
                                    let y = data.rotationRate.y
                                    let z = data.rotationRate.z
                                    
                                    print("GyroScope data X=\(x) Y=\(y) Z=\(z)")
                                    // Use the gyroscope data in your app.
                                    self.gyroX.text = String(x)
                                    self.gyroY.text = String(y)
                                    self.gyroZ.text = String(z)
                                }
            })
            
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer, forMode: .defaultRunLoopMode)
        }
    }
    
    @IBAction func accHandler(_ sender: Any) {
        
        if accHandler.isOn
        {
            startAccelerometers()
        }
        else
        {
            self.motion.stopAccelerometerUpdates()
        }
    }
    
    @IBAction func gyroHandler(_ sender: Any) {
       
        if gyroHandler.isOn
        {
            startGyros()
        }
        else
        {
            self.motion.stopGyroUpdates()
        }
    }
    
    
}
