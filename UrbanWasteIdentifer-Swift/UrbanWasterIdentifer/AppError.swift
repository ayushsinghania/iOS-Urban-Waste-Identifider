import Foundation

enum AppError: Error, CustomStringConvertible {

    case missingBMSCredentialsPlist

    case missingCredentials

    case invalidCredentials

    case installingTrainingModel

    case noData

    case error(String)

    var title: String {
        switch self {
        case .missingBMSCredentialsPlist: return "Missing BMSCredentials.plist"
        case .missingCredentials: return "Missing Visual Recognition Credentials"
        case .invalidCredentials: return "Invalid Visual Recognition Credentials"
        case .installingTrainingModel: return "Error Installing Core ML Model"
        case .noData: return "Bad Response"
        case .error: return "Visual Recognition Failed"
        }
    }

    var message: String {
        switch self {
        case .missingBMSCredentialsPlist: return "Please read the readme to ensure proper credentials configuration."
        case .missingCredentials: return "Please read the readme to ensure proper credentials configuration."
        case .invalidCredentials: return "Please read the readme to ensure proper credentials configuration."
        case .installingTrainingModel: return "Please ensure the Visual Recognition service has been configured and the model has been trained. For more information, check the readme."
        case .noData: return "No Visual Recognition data was received."
        case .error(let msg): return msg
        }
    }

    var description: String {
        return title + ": " + message
    }
}
