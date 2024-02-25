import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var textField: NSTextField!
    var timer: Timer?
    var notificationSound: NSSound?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the window
        let windowFrame = NSRect(x: 200, y: 200, width: 300, height: 100)
        window = NSWindow(contentRect: windowFrame, styleMask: [.titled], backing: .buffered, defer: false)
        window.title = "Take a Break"
        
        // Allow the window to be shown on all spaces and on top of full-screen windows
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        // Create the text field
        textField = NSTextField(frame: NSRect(x: 10, y: 40, width: 280, height: 20))
        textField.stringValue = "Time for a break"
        textField.isEditable = false
        textField.isSelectable = false
        textField.isBezeled = false
        textField.drawsBackground = false
        textField.alignment = .center
        
        window.contentView?.addSubview(textField)
        
        // Load notification sound
        if let soundPath = Bundle.main.path(forResource: "notification", ofType: "mp3") {
            notificationSound = NSSound(contentsOfFile: soundPath, byReference: true)
        }
        
        // Set up the timer to bring the window to the center and on top every 20x60 = 1200 seconds
        timer = Timer.scheduledTimer(timeInterval: 1200, target: self, selector: #selector(bringWindowToTopWithSound), userInfo: nil, repeats: true)
        
        // Show the window
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func bringWindowToTopWithSound() {
        guard let screen = NSScreen.main else { return }
        let windowFrame = window.frame
        let centerX = screen.frame.midX - windowFrame.width / 2
        let centerY = screen.frame.midY - windowFrame.height / 2
        window.setFrameOrigin(NSPoint(x: centerX, y: centerY))
        window.orderFrontRegardless()
        
        // Play notification sound
        notificationSound?.play()
    }
}
