import Foundation

public struct Reader {
    public static func read(file name: String) -> String {
        let components = name.components(separatedBy: ".")
        
        guard components.count == 2 else {
            return ""
        }
        
        guard let url = Bundle.main.url(forResource: components[0], withExtension: components[1]) else {
            return ""
        }

        let data = (try? String(contentsOf: url)) ?? ""

        return data
    }
    
    public static func readLines(from file: String) -> [String] {
        let data = read(file: file)
        
        return data.components(separatedBy: "\n")
    }
}
