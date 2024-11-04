import Foundation

// DetectedLanguage 모델
struct DetectedLanguage: Codable {
    let language: String
    let score: Double
}

// Translation 모델
struct Translation: Codable {
    let text: String
    let to: String
}

// 전체 응답 모델
struct Language: Codable {
    let detectedLanguage: DetectedLanguage
    let translations: [Translation]
}
