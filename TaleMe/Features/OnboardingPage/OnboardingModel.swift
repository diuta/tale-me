//
//  OnboardingModel.swift
//  sengkuyung
//
//  Created by Catherine Danielle on 06/07/26.
//

import SwiftUI

struct OnboardingModel: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
    let buttonTittle: String?
}

let onboardingPages = [
    OnboardingModel(
        image: "onboarding1_menyapa",
        title: "Tale Me!",
        subtitle: "",
        buttonTittle: nil
    ),
    OnboardingModel(
        image: "onboarding23_caritau",
        title: "Tonight, the story’s on us",
        subtitle: "We hand you the spark, a theme, a character, a 'what if.' You just start talking.",
        buttonTittle: nil
    ),
    OnboardingModel(
        image: "onboarding23_caritau",
        title: "Keeping what matters most",
        subtitle: "Their laugh, their questions, the way they lean in. Recorded without you lifting a finger.",
        buttonTittle: nil
    ),
    OnboardingModel(
        image: "onboarding4_happy",
        title: "A memory, not just a file",
        subtitle: "Every story becomes something you can hold onto.",
        buttonTittle: "Get Started"
    )
]
