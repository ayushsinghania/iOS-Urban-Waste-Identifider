

import Foundation
import VisualRecognition

/// Basic Classification initializer for example data
extension ClassResult {

    init(className: String, score: Double, typeHierarchy: String? = nil) {
        self.className = className
        self.score = score
        self.typeHierarchy = typeHierarchy
    }

}
