import Foundation

struct helpPrompt: Identifiable, Codable {
    let id: UUID
    let name: String
    let image: String
    let help: [String]
}

extension VerbPrompt {
    static let propsByVerb: [String: [helpPrompt]] = [
        "Swimming": [
            helpPrompt(id: UUID(), name: "Beach Chair", image: "beach_chair", help: [
                "What color would your beach chair be?",
                "Have you ever sat on a chair like that at the beach or pool?",
                "Who do you like sitting next to when you're at the pool?"
            ]),
            helpPrompt(id: UUID(), name: "Beachball", image: "beachball", help: [
                "What color is the beachball in the story?",
                "Have you ever played catch with a beachball?",
                "Who would you want to play beachball with?"
            ]),
            helpPrompt(id: UUID(), name: "Float", image: "floaties", help: [
                "Would you float on your back or your tummy?",
                "Have you ever used a float in the water before?",
                "Were you ever a little scared in the water? What helped?"
            ]),
            helpPrompt(id: UUID(), name: "Bucket", image: "seashell_bucket", help: [
                "What would you want to put inside the bucket?",
                "Have you ever collected shells or rocks at the beach?",
                "What's the coolest thing you've ever found outside?"
            ]),
            helpPrompt(id: UUID(), name: "Rubber Duck", image: "rubber_duck", help: [
                "What sound do you think the rubber duck makes?",
                "Have you ever played with a rubber duck in the bath?",
                "Do you have a favorite bath toy at home?"
            ]),
            helpPrompt(id: UUID(), name: "Swimming Pool", image: "swimming_pool", help: [
                "Is the water warm or cold in the story?",
                "Have you ever jumped into a pool before?",
                "Who taught you to swim, or who's teaching you now?"
            ]),
        ],
        "Adventuring": [
            helpPrompt(id: UUID(), name: "Compass", image: "compass", help: [
                "Which way is the compass pointing right now?",
                "Have you ever used something to help you find your way?",
                "Have you ever felt lost somewhere? What did you do?"
            ]),
            helpPrompt(id: UUID(), name: "Backpack", image: "backpack", help: [
                "What's one thing you'd pack in your backpack for the trip?",
                "Have you ever packed a bag to go somewhere?",
                "What do you always want to bring with you when you leave the house?"
            ]),
            helpPrompt(id: UUID(), name: "Treasure Chest", image: "treasure_box", help: [
                "What do you think is inside the treasure chest?",
                "Have you ever found something that felt like a treasure?",
                "What's something of yours that feels like a treasure to you?"
            ]),
            helpPrompt(id: UUID(), name: "Destination", image: "trail_sign", help: [
                "What does the sign say about where to go next?",
                "Have you ever followed a sign or a map somewhere?",
                "If you could go on an adventure anywhere, where would you go?"
            ]),
            helpPrompt(id: UUID(), name: "Tent", image: "camping_tent", help: [
                "What color is the tent in the story?",
                "Have you ever slept in a tent, inside or outside?",
                "Who would you want to share a tent with on a camping trip?"
            ]),
            helpPrompt(id: UUID(), name: "Camping Grounds", image: "camping_grounds", help: [
                "What sounds do you think you'd hear at the campsite?",
                "Have you ever been camping or slept somewhere new?",
                "What's your favorite thing to do outside with your family?"
            ]),
        ],
        "Fishing": [
            helpPrompt(id: UUID(), name: "Rod", image: "fishing_rod", help: [
                "What do you think will happen when the rod bends?",
                "Have you ever been fishing with someone in your family?",
                "What do you think it feels like when a fish tugs the line?"
            ]),
            helpPrompt(id: UUID(), name: "Bait", image: "tackle_bucket", help: [
                "What kind of bait do you think the fish likes best?",
                "Have you ever touched a worm or a bug like that?",
                "Is there a food you'd never want to touch, like the fish's bait?"
            ]),
            helpPrompt(id: UUID(), name: "Bucket", image: "bucket_fish", help: [
                "What would you put in your bucket if you caught something?",
                "Have you ever carried something heavy in a bucket?",
                "How many fish do you think would fit in that bucket?"
            ]),
            helpPrompt(id: UUID(), name: "Fish", image: "jumping_fish", help: [
                "What color do you think the fish is?",
                "Have you ever seen a fish up close before?",
                "Would you want to keep the fish or let it go back home? Why?"
            ]),
            helpPrompt(id: UUID(), name: "Pond", image: "pond", help: [
                "What do you think lives under the water in the pond?",
                "Have you ever visited a pond or a lake?",
                "What's your favorite place outside to visit with your family?"
            ]),
            helpPrompt(id: UUID(), name: "Fishing Net", image: "fishing_net", help: [
                "What do you think the net will catch first?",
                "Have you ever used a net to catch something, like bugs or fish?",
                "What's something you've tried hard to catch or find?"
            ]),
        ],
        "Exercising": [
            helpPrompt(id: UUID(), name: "Mat", image: "exercise_mat", help: [
                "What move would you do first on the mat?",
                "Have you ever stretched or rolled around on a mat?",
                "What's your favorite way to move your body at home?"
            ]),
            helpPrompt(id: UUID(), name: "Water Bottle", image: "water_bottle", help: [
                "What do you think is in the water bottle?",
                "Have you ever felt really thirsty after playing outside?",
                "What's your favorite drink after playing hard?"
            ]),
            helpPrompt(id: UUID(), name: "Stopwatch", image: "stopwatch", help: [
                "How fast do you think they're going in the story?",
                "Have you ever raced someone, like a friend or a sibling?",
                "Who's the fastest runner you know?"
            ]),
            helpPrompt(id: UUID(), name: "Chair", image: "exercise_chair", help: [
                "What exercise do you think they're doing with the chair?",
                "Have you ever used a chair to help you stretch or balance?",
                "What's something you practice to get stronger or better at?"
            ]),
            helpPrompt(id: UUID(), name: "Jump Rope", image: "jump_rope", help: [
                "How many jumps do you think they can do in a row?",
                "Have you ever tried jumping rope before?",
                "What's a game you like to play that makes you jump or run?"
            ]),
            helpPrompt(id: UUID(), name: "Park", image: "park", help: [
                "What do you think is at the park in the story?",
                "Have you ever played at a park near your house?",
                "What's your favorite thing to do at the park?"
            ]),
        ],
        "Cooking": [
            helpPrompt(id: UUID(), name: "Pan", image: "frying_pan", help: [
                "What sound do you think the food makes in the hot pan?",
                "Have you ever helped cook something in a pan at home?",
                "What's your favorite thing to cook or make with your family?"
            ]),
            helpPrompt(id: UUID(), name: "Saucepan", image: "cooking_pan", help: [
                "What do you think is cooking inside the saucepan?",
                "Have you ever stirred something on the stove with a grown-up?",
                "Who usually cooks at your house?"
            ]),
            helpPrompt(id: UUID(), name: "Oven", image: "oven", help: [
                "What do you think smells so good coming from the oven?",
                "Have you ever helped bake something, like cookies or bread?",
                "What's something yummy you'd want to bake with someone at home?"
            ]),
            helpPrompt(id: UUID(), name: "Recipe Book", image: "recipe_book", help: [
                "What do you think the recipe says to do next?",
                "Have you ever followed steps to make something, like a recipe or a craft?",
                "If you made your own recipe book, what would go in it first?"
            ]),
            helpPrompt(id: UUID(), name: "Soup", image: "soup", help: [
                "What do you think is inside the soup?",
                "Have you ever eaten soup that someone in your family made?",
                "What's your favorite meal that someone at home cooks for you?"
            ]),
            helpPrompt(id: UUID(), name: "Vegetables", image: "vegetables", help: [
                "Which vegetable do you think tastes the best?",
                "Have you ever helped wash or cut vegetables at home?",
                "What's a food you don't like that someone still wants you to try?"
            ]),
        ],
    ]

    var props: [helpPrompt] {
        VerbPrompt.propsByVerb[name] ?? []
    }
}
