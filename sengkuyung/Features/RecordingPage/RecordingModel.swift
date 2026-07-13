import Foundation

struct HelpPrompt: Identifiable, Codable {
    let id: UUID
    let name: String
    let image: String
    let help: [String]
}

extension VerbPrompt {
    static let propsByVerb: [String: [HelpPrompt]] = [
        "Swimming": [
            HelpPrompt(id: UUID(), name: "Swimming Goggles", image: "goggles", help: [
                "What color would your goggles be?",
                "Have you ever worn goggles in the water?",
                "Do things look different when you look through goggles?"
            ]),
            HelpPrompt(id: UUID(), name: "Beachball", image: "beachball", help: [
                "What color is the beachball?",
                "Have you ever played catch with a beachball?",
                "Who would you want to play beachball with?"
            ]),
            HelpPrompt(id: UUID(), name: "Floaties", image: "floaties", help: [
                "Would you float on your back or your tummy?",
                "Have you ever used a float in the water before?",
                "Can you act out how you float?"
            ]),
            HelpPrompt(id: UUID(), name: "Sunscreen", image: "sunscreen", help: [
                "How does sunscreen feel when it goes on your skin?",
                "Have you ever had sunscreen put on before going outside?",
                "Who usually helps you put on sunscreen?"
            ]),
            HelpPrompt(id: UUID(), name: "Towel", image: "towel", help: [
                "What color is the towel?",
                "Do you like the cozy wrapped up feeling?",
                "Who wraps you up in a towel when you're cold?"
            ]),
            HelpPrompt(id: UUID(), name: "Swimming Pool", image: "swimming_pool", help: [
                "Is the water warm or cold?",
                "Can you show how you jump into a pool?",
                "Who taught you to swim?"
            ]),
            HelpPrompt(id: UUID(), name: "Swimming Fins", image: "fin", help: [
                "Why do you think its called fins?",
                "Have you ever worn fins in the water?",
                "What would you do if your feet suddenly turns into fins?"
            ]),
        ],
        "Adventuring": [
            HelpPrompt(id: UUID(), name: "Compass", image: "compass", help: [
                "What do you think the S and N on the compass mean?",
                "Which way is north? Which way is south?",
                "Have you ever felt lost somewhere?"
            ]),
            HelpPrompt(id: UUID(), name: "Backpack", image: "backpack", help: [
                "What's one thing you'd pack in your backpack for the trip?",
                "Have you ever packed a bag to go somewhere?",
                "What do you always want to bring with you when you leave the house?"
            ]),
            HelpPrompt(id: UUID(), name: "Treasure Chest", image: "treasure_box", help: [
                "What do you think is inside the treasure chest?",
                "Have you ever found something that felt like a treasure?",
                "What's something of yours that feels like a treasure to you?"
            ]),
            HelpPrompt(id: UUID(), name: "Destination", image: "trail_sign", help: [
                "What does the sign say about where to go next?",
                "Have you ever followed a sign or a map somewhere?",
                "If you could go on an adventure anywhere, where would you go?"
            ]),
            HelpPrompt(id: UUID(), name: "Tent", image: "camping_tent", help: [
                "What color is the tent in the story?",
                "Have you ever slept in a tent, inside or outside?",
                "Who would you want to share a tent with on a camping trip?"
            ]),
            HelpPrompt(id: UUID(), name: "Camping Grounds", image: "camping_grounds", help: [
                "What sounds do you think you'd hear at the campsite?",
                "Have you ever been camping or slept somewhere new?",
                "What's your favorite thing to do outside with your family?"
            ]),
            HelpPrompt(id: UUID(), name: "Treasure Map", image: "treasure_map", help: [
                "What do you think the map will lead them to?",
                "Have you ever followed a map, or drawn one yourself?",
                "If you drew a map of your house, where would you hide a treasure?"
            ]),
        ],
        "Fishing": [
            HelpPrompt(id: UUID(), name: "Rod", image: "fishing_rod", help: [
                "What do you think will happen when the rod bends?",
                "Have you ever been fishing with someone in your family?",
                "What do you think it feels like when a fish tugs the line?"
            ]),
            HelpPrompt(id: UUID(), name: "Fishing Chair", image: "fishing_chair", help: [
                "Who would you want to sit next to on the fishing chair?",
                "Have you ever had to sit and wait quietly for something?",
                "What's something you have to be patient for?"
            ]),
            HelpPrompt(id: UUID(), name: "Bucket", image: "bucket_fish", help: [
                "What would you put in your bucket if you caught something?",
                "Have you ever carried something heavy in a bucket?",
                "How many fish do you think would fit in that bucket?"
            ]),
            HelpPrompt(id: UUID(), name: "Fish", image: "jumping_fish", help: [
                "What color do you think the fish is?",
                "Have you ever seen a fish up close before?",
                "Would you want to keep the fish or let it go back home? Why?"
            ]),
            HelpPrompt(id: UUID(), name: "Pond", image: "pond", help: [
                "What do you think lives under the water in the pond?",
                "Have you ever visited a pond or a lake?",
                "What's your favorite place outside to visit with your family?"
            ]),
            HelpPrompt(id: UUID(), name: "Fishing Net", image: "fishing_net", help: [
                "What do you think the net will catch first?",
                "Have you ever used a net to catch something, like bugs or fish?",
                "What's something you've tried hard to catch or find?"
            ]),
            HelpPrompt(id: UUID(), name: "Tackle Box", image: "tackle_bucket", help: [
                "What do you think is inside the tackle box?",
                "Have you ever kept small things organized in a box?",
                "What's your favorite thing to keep in a special box?"
            ]),
        ],
        "Exercising": [
            HelpPrompt(id: UUID(), name: "Mat", image: "exercise_mat", help: [
                "What move would you do first on the mat?",
                "Have you ever stretched or rolled around on a mat?",
                "What's your favorite way to move your body at home?"
            ]),
            HelpPrompt(id: UUID(), name: "Water Bottle", image: "water_bottle", help: [
                "What do you think is in the water bottle?",
                "Have you ever felt really thirsty after playing outside?",
                "What's your favorite drink after playing hard?"
            ]),
            HelpPrompt(id: UUID(), name: "Stopwatch", image: "stopwatch", help: [
                "How fast do you think they're going in the story?",
                "Have you ever raced someone, like a friend or a sibling?",
                "Who's the fastest runner you know?"
            ]),
            HelpPrompt(id: UUID(), name: "Shoes", image: "shoes", help: [
                "What color are the shoes in the story?",
                "Have you ever gotten new shoes for running or playing?",
                "What's your favorite thing to do in your sneakers?"
            ]),
            HelpPrompt(id: UUID(), name: "Jump Rope", image: "jump_rope", help: [
                "How many jumps do you think they can do in a row?",
                "Have you ever tried jumping rope before?",
                "What's a game you like to play that makes you jump or run?"
            ]),
            HelpPrompt(id: UUID(), name: "Park", image: "park", help: [
                "What do you think is at the park in the story?",
                "Have you ever played at a park near your house?",
                "What's your favorite thing to do at the park?"
            ]),
            HelpPrompt(id: UUID(), name: "Dumbell", image: "dumbell", help: [
                "How heavy do you think the dumbbell is?",
                "Have you ever tried to lift something heavy?",
                "What's something you had to practice to get stronger at?"
            ]),
        ],
        "Cooking": [
            HelpPrompt(id: UUID(), name: "Pan", image: "frying_pan", help: [
                "What sound do you think the food makes in the hot pan?",
                "Have you ever helped cook something in a pan at home?",
                "What's your favorite thing to cook or make with your family?"
            ]),
            HelpPrompt(id: UUID(), name: "Meat", image: "meat", help: [
                "What kind of meat do you think they're cooking?",
                "Have you ever smelled something cooking in the kitchen?",
                "What's your favorite meal that someone cooks for you?"
            ]),
            HelpPrompt(id: UUID(), name: "Oven", image: "oven", help: [
                "What do you think smells so good coming from the oven?",
                "Have you ever helped bake something, like cookies or bread?",
                "What's something yummy you'd want to bake with someone at home?"
            ]),
            HelpPrompt(id: UUID(), name: "Recipe Book", image: "recipe_book", help: [
                "What do you think the recipe says to do next?",
                "What recipe have you ever tried to follow?",
                "If you made your own recipe book, what would go in it first?"
            ]),
            HelpPrompt(id: UUID(), name: "Soup", image: "soup", help: [
                "What do you think is inside the soup?",
                "Have you ever eaten soup that someone in your family made?",
                "What's your favorite meal that someone at home cooks for you?"
            ]),
            HelpPrompt(id: UUID(), name: "Vegetables", image: "vegetables", help: [
                "Which vegetable do you think tastes the best?",
                "Have you ever helped wash or cut vegetables at home?",
                "What's a food you don't like that someone still wants you to try?"
            ]),
            HelpPrompt(id: UUID(), name: "Apron", image: "apron", help: [
                "What color is the apron in the story?",
                "Have you ever worn an apron to help cook or paint?",
                "Who do you like helping with in the kitchen?"
            ]),
        ],
    ]
    
    var props: [HelpPrompt] {
        VerbPrompt.propsByVerb[name] ?? []
    }
}
