//
//  Recipe.swift
//  FetchRewards-Interview
//
//  Created by Vikas Shah on 6/28/23.
//

import Foundation

struct Recipe: Codable, Equatable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strTags: String?
    let strYoutube: String?

    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?

    // swiftlint:disable:next function_body_length
    init(
        idMeal: String,
        strMeal: String,
        strMealThumb: String,
        strDrinkAlternate: String? = nil,
        strCategory: String? = nil,
        strArea: String? = nil,
        strInstructions: String? = nil,
        strTags: String? = nil,
        strYoutube: String? = nil,
        strIngredient1: String? = nil,
        strIngredient2: String? = nil,
        strIngredient3: String? = nil,
        strIngredient4: String? = nil,
        strIngredient5: String? = nil,
        strIngredient6: String? = nil,
        strIngredient7: String? = nil,
        strIngredient8: String? = nil,
        strIngredient9: String? = nil,
        strIngredient10: String? = nil,
        strIngredient11: String? = nil,
        strIngredient12: String? = nil,
        strIngredient13: String? = nil,
        strIngredient14: String? = nil,
        strIngredient15: String? = nil,
        strIngredient16: String? = nil,
        strIngredient17: String? = nil,
        strIngredient18: String? = nil,
        strIngredient19: String? = nil,
        strIngredient20: String? = nil,
        strMeasure1: String? = nil,
        strMeasure2: String? = nil,
        strMeasure3: String? = nil,
        strMeasure4: String? = nil,
        strMeasure5: String? = nil,
        strMeasure6: String? = nil,
        strMeasure7: String? = nil,
        strMeasure8: String? = nil,
        strMeasure9: String? = nil,
        strMeasure10: String? = nil,
        strMeasure11: String? = nil,
        strMeasure12: String? = nil,
        strMeasure13: String? = nil,
        strMeasure14: String? = nil,
        strMeasure15: String? = nil,
        strMeasure16: String? = nil,
        strMeasure17: String? = nil,
        strMeasure18: String? = nil,
        strMeasure19: String? = nil,
        strMeasure20: String? = nil,
        strSource: String? = nil,
        strImageSource: String? = nil,
        strCreativeCommonsConfirmed: String? = nil,
        dateModified: String? = nil
    ) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb

        self.strDrinkAlternate = strDrinkAlternate
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
        self.strTags = strTags
        self.strYoutube = strYoutube

        self.strIngredient1 = strIngredient1
        self.strIngredient2 = strIngredient2
        self.strIngredient3 = strIngredient3
        self.strIngredient4 = strIngredient4
        self.strIngredient5 = strIngredient5
        self.strIngredient6 = strIngredient6
        self.strIngredient7 = strIngredient7
        self.strIngredient8 = strIngredient8
        self.strIngredient9 = strIngredient9
        self.strIngredient10 = strIngredient10
        self.strIngredient11 = strIngredient11
        self.strIngredient12 = strIngredient12
        self.strIngredient13 = strIngredient13
        self.strIngredient14 = strIngredient14
        self.strIngredient15 = strIngredient15
        self.strIngredient16 = strIngredient16
        self.strIngredient17 = strIngredient17
        self.strIngredient18 = strIngredient18
        self.strIngredient19 = strIngredient19
        self.strIngredient20 = strIngredient20
        self.strMeasure1 = strMeasure1
        self.strMeasure2 = strMeasure2
        self.strMeasure3 = strMeasure3
        self.strMeasure4 = strMeasure4
        self.strMeasure5 = strMeasure5
        self.strMeasure6 = strMeasure6
        self.strMeasure7 = strMeasure7
        self.strMeasure8 = strMeasure8
        self.strMeasure9 = strMeasure9
        self.strMeasure10 = strMeasure10
        self.strMeasure11 = strMeasure11
        self.strMeasure12 = strMeasure12
        self.strMeasure13 = strMeasure13
        self.strMeasure14 = strMeasure14
        self.strMeasure15 = strMeasure15
        self.strMeasure16 = strMeasure16
        self.strMeasure17 = strMeasure17
        self.strMeasure18 = strMeasure18
        self.strMeasure19 = strMeasure19
        self.strMeasure20 = strMeasure20

        self.strSource = strSource
        self.strImageSource = strImageSource
        self.strCreativeCommonsConfirmed = strCreativeCommonsConfirmed
        self.dateModified = dateModified
    }

    // swiftlint:disable:next function_body_length
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strDrinkAlternate = try container.decodeIfPresent(String.self, forKey: .strDrinkAlternate)
        self.strCategory = try container.decodeIfPresent(String.self, forKey: .strCategory)
        self.strArea = try container.decodeIfPresent(String.self, forKey: .strArea)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strTags = try container.decodeIfPresent(String.self, forKey: .strTags)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        self.strIngredient1 = try container.decodeIfPresent(String.self, forKey: .strIngredient1)
        self.strIngredient2 = try container.decodeIfPresent(String.self, forKey: .strIngredient2)
        self.strIngredient3 = try container.decodeIfPresent(String.self, forKey: .strIngredient3)
        self.strIngredient4 = try container.decodeIfPresent(String.self, forKey: .strIngredient4)
        self.strIngredient5 = try container.decodeIfPresent(String.self, forKey: .strIngredient5)
        self.strIngredient6 = try container.decodeIfPresent(String.self, forKey: .strIngredient6)
        self.strIngredient7 = try container.decodeIfPresent(String.self, forKey: .strIngredient7)
        self.strIngredient8 = try container.decodeIfPresent(String.self, forKey: .strIngredient8)
        self.strIngredient9 = try container.decodeIfPresent(String.self, forKey: .strIngredient9)
        self.strIngredient10 = try container.decodeIfPresent(String.self, forKey: .strIngredient10)
        self.strIngredient11 = try container.decodeIfPresent(String.self, forKey: .strIngredient11)
        self.strIngredient12 = try container.decodeIfPresent(String.self, forKey: .strIngredient12)
        self.strIngredient13 = try container.decodeIfPresent(String.self, forKey: .strIngredient13)
        self.strIngredient14 = try container.decodeIfPresent(String.self, forKey: .strIngredient14)
        self.strIngredient15 = try container.decodeIfPresent(String.self, forKey: .strIngredient15)
        self.strIngredient16 = try container.decodeIfPresent(String.self, forKey: .strIngredient16)
        self.strIngredient17 = try container.decodeIfPresent(String.self, forKey: .strIngredient17)
        self.strIngredient18 = try container.decodeIfPresent(String.self, forKey: .strIngredient18)
        self.strIngredient19 = try container.decodeIfPresent(String.self, forKey: .strIngredient19)
        self.strIngredient20 = try container.decodeIfPresent(String.self, forKey: .strIngredient20)
        self.strMeasure1 = try container.decodeIfPresent(String.self, forKey: .strMeasure1)
        self.strMeasure2 = try container.decodeIfPresent(String.self, forKey: .strMeasure2)
        self.strMeasure3 = try container.decodeIfPresent(String.self, forKey: .strMeasure3)
        self.strMeasure4 = try container.decodeIfPresent(String.self, forKey: .strMeasure4)
        self.strMeasure5 = try container.decodeIfPresent(String.self, forKey: .strMeasure5)
        self.strMeasure6 = try container.decodeIfPresent(String.self, forKey: .strMeasure6)
        self.strMeasure7 = try container.decodeIfPresent(String.self, forKey: .strMeasure7)
        self.strMeasure8 = try container.decodeIfPresent(String.self, forKey: .strMeasure8)
        self.strMeasure9 = try container.decodeIfPresent(String.self, forKey: .strMeasure9)
        self.strMeasure10 = try container.decodeIfPresent(String.self, forKey: .strMeasure10)
        self.strMeasure11 = try container.decodeIfPresent(String.self, forKey: .strMeasure11)
        self.strMeasure12 = try container.decodeIfPresent(String.self, forKey: .strMeasure12)
        self.strMeasure13 = try container.decodeIfPresent(String.self, forKey: .strMeasure13)
        self.strMeasure14 = try container.decodeIfPresent(String.self, forKey: .strMeasure14)
        self.strMeasure15 = try container.decodeIfPresent(String.self, forKey: .strMeasure15)
        self.strMeasure16 = try container.decodeIfPresent(String.self, forKey: .strMeasure16)
        self.strMeasure17 = try container.decodeIfPresent(String.self, forKey: .strMeasure17)
        self.strMeasure18 = try container.decodeIfPresent(String.self, forKey: .strMeasure18)
        self.strMeasure19 = try container.decodeIfPresent(String.self, forKey: .strMeasure19)
        self.strMeasure20 = try container.decodeIfPresent(String.self, forKey: .strMeasure20)
        self.strSource = try container.decodeIfPresent(String.self, forKey: .strSource)
        self.strImageSource = try container.decodeIfPresent(String.self, forKey: .strImageSource)
        self.strCreativeCommonsConfirmed = try container.decodeIfPresent(String.self,
                                                                         forKey: .strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: .dateModified)
    }
}
