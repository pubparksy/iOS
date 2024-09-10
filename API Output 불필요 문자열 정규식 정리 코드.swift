/** API Output 불필요 문자열 정규식 정리 코드 */
extension String {
    var stripHTML : String {
        return self.replacingOccurrences(of: "<[^>]>", with: "", options: .regularExpression)
    }
    
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else { return nil }
            
            let attributed =
            try NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch  {
            return nil
        }
    }
}
