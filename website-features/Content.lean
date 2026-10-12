structure Translation where
  en : String
  fr : String
deriving Inhabited

def Translation.get (value : Translation) (language : String) : String :=
  if language == "fr" then value.fr else value.en

structure Item where
  slug : String
  title : Translation
  category : Translation
  summary : Translation
  body : Translation
  metadata : Translation
  initials : String := ""
  group : Translation := ⟨"", ""⟩
deriving Inhabited

inductive Layout where
  | posts | projects | partners | people | theory
deriving BEq, Inhabited

structure Section where
  slug : String
  title : Translation
  intro : Translation
  layout : Layout
  items : Array Item
deriving Inhabited

def sections : Array Section := #[
  { slug := "recipes", title := ⟨"Recipes", "Recettes"⟩,
    intro := ⟨"Reliable, flexible food for real-life weeknights.", "Des recettes fiables et flexibles pour les soirs de semaine."⟩,
    layout := .posts, items := #[
      { slug := "tomato-chickpea-traybake", title := ⟨"Tomato & chickpea traybake", "Pois chiches et tomates rôtis au four"⟩,
        category := ⟨"Dinner · 35 minutes", "Dîner · 35 minutes"⟩,
        summary := ⟨"A hands-off pan of crisp chickpeas, sweet tomatoes and lemony yogurt.", "Un plat sans surveillance de pois chiches croustillants, tomates fondantes et yaourt citronné."⟩,
        body := ⟨"Heat the oven to 220°C. Toss two drained tins of chickpeas and 500 g cherry tomatoes with olive oil, smoked paprika, salt and pepper. Roast on a wide tray for 25 minutes, turning once. Stir lemon zest and juice into thick yogurt, spoon it over the hot tray and finish with parsley. Add bread or cooked grains to make it go further. For a MixMate kitchen, use the appliance to mix the yogurt dressing; the oven does the roasting.", "Chauffez le four à 220 °C. Mélangez deux boîtes de pois chiches égouttés et 500 g de tomates cerises avec de l'huile d'olive, du paprika fumé, du sel et du poivre. Faites rôtir sur une grande plaque pendant 25 minutes en remuant une fois. Mélangez le zeste et le jus d'un citron au yaourt épais, versez sur le plat chaud et terminez avec du persil. Servez avec du pain ou des céréales cuites. Dans une cuisine équipée d'un MixMate, préparez-y la sauce au yaourt ; le four s'occupe de la cuisson."⟩,
        metadata := ⟨"Serves 4 · Vegetarian · 10 min prep", "4 personnes · Végétarien · 10 min de préparation"⟩ },
      { slug := "green-lentil-soup", title := ⟨"Green lentil & leek soup", "Soupe de lentilles vertes et poireaux"⟩,
        category := ⟨"Lunch · 45 minutes", "Déjeuner · 45 minutes"⟩,
        summary := ⟨"A filling pot of lentils, leeks and greens with a bright herb finish.", "Un plat nourrissant de lentilles, poireaux et légumes verts, relevé d'herbes fraîches."⟩,
        body := ⟨"Soften one sliced leek and a diced carrot in a little oil for 6 minutes. Add 250 g rinsed green lentils, 1.2 litres vegetable stock and a bay leaf. Simmer until the lentils are tender, about 30 minutes. Stir in chopped spinach or chard for the last 3 minutes. Season with lemon juice and black pepper. Blend a cup of soup and return it to the pot for a thicker texture, or leave it brothy. Refrigerate leftovers promptly and use within three days.", "Faites revenir un poireau émincé et une carotte en dés dans un peu d'huile pendant 6 minutes. Ajoutez 250 g de lentilles vertes rincées, 1,2 litre de bouillon de légumes et une feuille de laurier. Laissez mijoter environ 30 minutes, jusqu'à ce que les lentilles soient tendres. Ajoutez des épinards ou des blettes hachés pendant les 3 dernières minutes. Assaisonnez avec du jus de citron et du poivre. Mixez une louche de soupe et reversez-la pour épaissir le tout, ou gardez une texture plus légère. Réfrigérez rapidement les restes et consommez-les sous trois jours."⟩,
        metadata := ⟨"Serves 4 · Vegan · Freezer-friendly", "4 personnes · Végétalien · Se congèle"⟩ },
      { slug := "apple-oat-pancakes", title := ⟨"Apple & oat pancakes", "Pancakes aux pommes et à l'avoine"⟩,
        category := ⟨"Breakfast · 20 minutes", "Petit-déjeuner · 20 minutes"⟩,
        summary := ⟨"Soft-centred pancakes that use one apple and a handful of cupboard staples.", "Des pancakes moelleux qui utilisent une pomme et quelques ingrédients du placard."⟩,
        body := ⟨"Grate one apple into a bowl and mix with one egg, 150 ml milk, 100 g plain flour, 50 g rolled oats, one teaspoon baking powder and a pinch of cinnamon. Rest for 5 minutes. Cook small spoonfuls in a lightly oiled pan over medium heat for 2 to 3 minutes per side. Serve with plain yogurt or fruit. For an egg-free version, use a mashed banana and add a splash more milk if needed.", "Râpez une pomme dans un saladier et mélangez avec un œuf, 150 ml de lait, 100 g de farine, 50 g de flocons d'avoine, une cuillère à café de levure chimique et une pincée de cannelle. Laissez reposer 5 minutes. Faites cuire de petites portions dans une poêle légèrement huilée, à feu moyen, 2 à 3 minutes de chaque côté. Servez avec du yaourt nature ou des fruits. Pour une version sans œuf, utilisez une banane écrasée et ajoutez un peu de lait si nécessaire."⟩,
        metadata := ⟨"Makes 8 · Vegetarian · 10 min prep", "8 pancakes · Végétarien · 10 min de préparation"⟩ }
    ] },
  { slug := "tools", title := ⟨"Tools", "Outils"⟩,
    intro := ⟨"A couple of useful kitchen companions, with a clear-eyed view of what they do.", "Quelques outils utiles en cuisine, présentés sans leur prêter plus qu'ils ne font."⟩,
    layout := .projects, items := #[
      { slug := "appliances/foodmate", title := ⟨"FoodMate", "FoodMate"⟩,
        group := ⟨"Appliances", "Appareils"⟩,
        category := ⟨"Kitchen appliance", "Appareil de cuisine"⟩,
        summary := ⟨"A hands-on helper for chopping, blending and preparing everyday ingredients.", "Un assistant pratique pour hacher, mixer et préparer les ingrédients du quotidien."⟩,
        body := ⟨"FoodMate is an example countertop appliance for common prep tasks such as chopping vegetables, blending soups and mixing sauces. It is optional: the recipes work with ordinary knives, bowls and pans too. Follow the instructions and safety guidance for the appliance you own, and use an oven or stovetop when a recipe calls for roasting or searing.", "FoodMate est un exemple d'appareil de cuisine pour les gestes courants comme hacher des légumes, mixer une soupe ou mélanger une sauce. Il reste facultatif : les recettes se préparent aussi avec des couteaux, bols et casseroles ordinaires. Suivez les instructions et consignes de sécurité de votre appareil, et utilisez le four ou la cuisinière lorsque la recette demande de rôtir ou saisir."⟩,
        metadata := ⟨"Appliance note · Not an endorsement", "Note appareil · Sans recommandation commerciale"⟩ },
      { slug := "appliances/mixmate", title := ⟨"MixMate", "MixMate"⟩,
        group := ⟨"Appliances", "Appareils"⟩,
        category := ⟨"Kitchen appliance", "Appareil de cuisine"⟩,
        summary := ⟨"A guided-cooking appliance for weighing, chopping, mixing, steaming and more.", "Un robot cuiseur avec pesée intégrée pour hacher, mélanger, cuire à la vapeur et plus encore."⟩,
        body := ⟨"MixMate can make prep and repeatable steps easier: weigh ingredients in the bowl, chop aromatics, stir sauces and steam vegetables. It is not required for any recipe here. Check the instructions for your model, follow its safety guidance and use a separate oven or pan where a recipe calls for roasting or searing. Product features and recipe availability vary by model and market.", "MixMate peut simplifier la préparation et les gestes répétitifs : peser dans le bol, hacher les aromates, mélanger les sauces et cuire les légumes à la vapeur. Aucune recette ici ne l'exige. Consultez les instructions de votre modèle, respectez les consignes de sécurité et utilisez un four ou une poêle si la recette demande de rôtir ou saisir. Les fonctions et recettes disponibles varient selon le modèle et le marché."⟩,
        metadata := ⟨"Tool note · Not an endorsement", "Note sur l'outil · Sans recommandation commerciale"⟩ },
      { slug := "apps/label-lens", title := ⟨"LabelLens", "LabelLens"⟩,
        group := ⟨"Apps", "Applications"⟩,
        category := ⟨"Food-label scanning app", "Application de lecture des étiquettes"⟩,
        summary := ⟨"Scan a packaged product barcode to see the app's nutrition and additive assessment.", "Scannez le code-barres d'un produit emballé pour consulter l'évaluation nutritionnelle et des additifs de l'application."⟩,
        body := ⟨"A barcode-scanning app can be a quick prompt to read a label more closely. Treat its score as one interpretation, not a diagnosis or a complete measure of whether a food suits you. Scores depend on the app's method and product data; they may not reflect portion size, your dietary needs or the whole meal. Compare the ingredient list and nutrition panel, and consult a qualified professional for personal medical or nutrition advice.", "Une application de lecture de codes-barres peut inciter à regarder une étiquette de plus près. Considérez sa note comme une interprétation, et non comme un diagnostic ou une mesure complète de l'adéquation d'un aliment à vos besoins. Les scores dépendent de la méthode de l'application et des données produit ; ils ne tiennent pas nécessairement compte de la portion, de vos besoins ni du repas entier. Consultez la liste des ingrédients et le tableau nutritionnel, et demandez conseil à un professionnel qualifié pour toute question personnelle de santé ou de nutrition."⟩,
        metadata := ⟨"Tool note · Product data may vary", "Note sur l'outil · Données produit variables"⟩ },
      { slug := "apps/calorie-optics", title := ⟨"CalorieOptics", "CalorieOptics"⟩,
        group := ⟨"Apps", "Applications"⟩,
        category := ⟨"Food diary app", "Application de journal alimentaire"⟩,
        summary := ⟨"A fictional food diary for noting meals and viewing estimated nutrition totals.", "Un journal alimentaire fictif pour noter les repas et consulter des estimations nutritionnelles."⟩,
        body := ⟨"CalorieOptics is a fictional example app for logging meals and viewing estimated calorie or nutrient totals. Any estimate depends on the accuracy of the entries and database, and should not be treated as a diagnosis, a precise measurement or a substitute for professional advice. Food tracking is not suitable for everyone; use it only if it supports your wellbeing, and seek qualified help for personal health concerns.", "CalorieOptics est un exemple fictif d'application pour noter les repas et consulter des estimations de calories ou de nutriments. Toute estimation dépend de la précision des saisies et de la base de données ; elle ne constitue ni un diagnostic, ni une mesure exacte, ni un remplacement d'un avis professionnel. Le suivi alimentaire ne convient pas à tout le monde ; utilisez-le uniquement s'il contribue à votre bien-être et demandez conseil à un professionnel pour toute question de santé personnelle."⟩,
        metadata := ⟨"App note · Estimates are not medical advice", "Note application · Estimations sans valeur médicale"⟩ }
    ] },
  { slug := "supermarkets", title := ⟨"Supermarkets", "Supermarchés"⟩,
    intro := ⟨"Familiar places to shop. Availability, ranges and prices can change by store and season.", "Des enseignes familières pour faire ses courses. L'offre et les prix varient selon le magasin et la saison."⟩,
    layout := .partners, items := #[
      { slug := "freshmart", title := ⟨"FreshMart", "FreshMart"⟩, initials := "F",
        category := ⟨"Swiss supermarket", "Supermarché suisse"⟩,
        summary := ⟨"A place to look for seasonal produce, pantry basics and convenient meal ingredients.", "Une enseigne où chercher des produits de saison, des indispensables du placard et des ingrédients pratiques."⟩,
        body := ⟨"Use the recipe list as a flexible shopping guide, not a promise that a specific product is stocked. Check the local store for current availability, prices, package sizes and product information. Swap ingredients when needed: canned beans can replace dried beans in quick recipes, and one leafy green can often stand in for another.", "Utilisez les recettes comme guide de courses flexible, et non comme garantie de disponibilité d'un produit précis. Vérifiez auprès du magasin les stocks, prix, formats et informations produit du moment. Remplacez les ingrédients selon les besoins : les haricots en conserve conviennent aux recettes rapides, et un légume-feuille peut souvent en remplacer un autre."⟩,
        metadata := ⟨"Retailer listing · No affiliation implied", "Enseigne · Aucune affiliation suggérée"⟩ },
      { slug := "dailymarket", title := ⟨"DailyMarket", "DailyMarket"⟩, initials := "D",
        category := ⟨"Swiss supermarket", "Supermarché suisse"⟩,
        summary := ⟨"Plan around what is fresh and available at your nearest DailyMarket store.", "Composez vos menus selon les produits frais et les disponibilités de votre magasin DailyMarket."⟩,
        body := ⟨"The meal ideas are designed to work with ordinary supermarket ingredients. Availability, prices, own-brand ranges and labels differ between locations and over time, so confirm details in store. Compare unit prices where useful, and check packaging for allergens and dietary claims rather than relying on a recipe page or an app score alone.", "Les idées de repas sont conçues pour des ingrédients courants de supermarché. Les stocks, prix, gammes de marque propre et étiquetages varient selon le lieu et la période ; vérifiez les détails en magasin. Comparez les prix au kilo ou au litre si utile, et consultez les emballages pour les allergènes et indications alimentaires plutôt que de vous fier uniquement à une recette ou à la note d'une application."⟩,
        metadata := ⟨"Retailer listing · No affiliation implied", "Enseigne · Aucune affiliation suggérée"⟩ }
    ] },
  { slug := "meal-plans", title := ⟨"Meal Plans", "Menus de la semaine"⟩,
    intro := ⟨"A little structure for the week, with room to use what is already in the fridge.", "Un peu d'organisation pour la semaine, en gardant de la place pour ce qu'il y a déjà au réfrigérateur."⟩,
    layout := .people, items := #[
      { slug := "five-easy-evenings", title := ⟨"Five easy evenings", "Cinq dîners faciles"⟩, initials := "5",
        category := ⟨"Weeknight plan", "Menu de semaine"⟩,
        summary := ⟨"Batch one pot of grains, then mix quick dinners from vegetables, beans and eggs.", "Préparez une casserole de céréales, puis composez des dîners rapides avec légumes, haricots et œufs."⟩,
        body := ⟨"Monday: lentil soup. Tuesday: chickpea traybake with leftover grains. Wednesday: omelette with any remaining greens. Thursday: pasta with tomatoes and white beans. Friday: baked potatoes topped with leftover soup or yogurt and herbs. Cook only what you can chill and store safely; freeze extra portions promptly. This is a flexible outline, not a prescribed diet.", "Lundi : soupe de lentilles. Mardi : pois chiches rôtis avec les céréales restantes. Mercredi : omelette avec les légumes verts restants. Jeudi : pâtes aux tomates et haricots blancs. Vendredi : pommes de terre au four garnies d'un reste de soupe, de yaourt et d'herbes. Ne préparez que ce que vous pouvez refroidir et conserver correctement ; congelez rapidement les portions en trop. Ce menu est une trame flexible, pas un régime prescrit."⟩,
        metadata := ⟨"Plan · 5 dinners · Adapt portions to your household", "Menu · 5 dîners · Adaptez les portions à votre foyer"⟩ },
      { slug := "use-it-up", title := ⟨"The use-it-up week", "La semaine anti-gaspi"⟩, initials := "0",
        category := ⟨"Low-waste plan", "Menu anti-gaspillage"⟩,
        summary := ⟨"Start with the ingredients you have, then shop for just a few flexible additions.", "Partez des ingrédients disponibles et n'achetez que quelques compléments polyvalents."⟩,
        body := ⟨"Before shopping, check the fridge, freezer and cupboard, then list foods that need using first. Turn soft vegetables into soup, roast mixed odds and ends on one tray, and use cooked grains in a salad or fritter. Choose a few flexible additions such as eggs, yogurt, lemons or canned beans. Follow package storage advice and use your judgement: discard food that may be unsafe.", "Avant les courses, vérifiez le réfrigérateur, le congélateur et les placards, puis notez les aliments à utiliser en priorité. Transformez les légumes fatigués en soupe, faites rôtir les restes assortis sur une plaque et ajoutez les céréales cuites à une salade ou à des galettes. Choisissez quelques compléments polyvalents comme des œufs, du yaourt, des citrons ou des haricots en conserve. Respectez les conseils de conservation et faites preuve de discernement : jetez tout aliment qui pourrait être impropre à la consommation."⟩,
        metadata := ⟨"Plan · Flexible quantities · Check food safety", "Menu · Quantités flexibles · Respectez la sécurité alimentaire"⟩ }
    ] },
  { slug := "kitchen-basics", title := ⟨"Kitchen Basics", "Bases en cuisine"⟩,
    intro := ⟨"Small habits that make everyday cooking easier, safer and more adaptable.", "Quelques habitudes simples pour cuisiner au quotidien plus facilement, en sécurité et avec souplesse."⟩,
    layout := .theory, items := #[
      { slug := "swap-with-confidence", title := ⟨"Swap with confidence", "Remplacer sans hésiter"⟩,
        category := ⟨"01 · Adapt", "01 · Adapter"⟩,
        summary := ⟨"Use the recipe as a framework and make sensible substitutions from your kitchen.", "Prenez la recette comme point de départ et faites des substitutions adaptées à votre cuisine."⟩,
        body := ⟨"A recipe is a useful starting point, not a contract. Similar vegetables, beans and herbs can often be swapped in equal amounts. Changes to flour, liquid, raising agents and oven temperature can affect baking more, so adjust those carefully. Taste as you go, note what worked and label any leftovers with the date.", "Une recette est un bon point de départ, pas un contrat. On peut souvent remplacer des légumes, légumineuses et herbes par des équivalents en quantités similaires. Les changements de farine, de liquide, de levure et de température influencent davantage la pâtisserie : faites-les avec prudence. Goûtez en cours de préparation, notez ce qui fonctionne et datez les restes."⟩,
        metadata := ⟨"Kitchen note · Flexible cooking", "Conseil cuisine · Cuisine flexible"⟩ },
      { slug := "read-the-label", title := ⟨"Read the label", "Lire l'étiquette"⟩,
        category := ⟨"02 · Check", "02 · Vérifier"⟩,
        summary := ⟨"Use ingredient lists and nutrition panels alongside any digital score.", "Consultez la liste des ingrédients et les valeurs nutritionnelles, même avec une note numérique."⟩,
        body := ⟨"Product labels give context that a single score cannot: ingredients, allergens, serving information and nutrition per 100 g or per portion. Different people have different needs. If you use a scanning app, treat it as a prompt to compare products, not as personalised medical advice. Check the actual package because product formulas can change.", "Les étiquettes apportent un contexte qu'une note seule ne donne pas : ingrédients, allergènes, informations par portion et valeurs pour 100 g ou par portion. Les besoins diffèrent d'une personne à l'autre. Si vous utilisez une application de scan, servez-vous-en pour comparer les produits, pas comme conseil médical personnalisé. Vérifiez l'emballage, car les recettes des produits peuvent changer."⟩,
        metadata := ⟨"Kitchen note · Product information", "Conseil cuisine · Informations produit"⟩ },
      { slug := "store-leftovers", title := ⟨"Cool, store, reheat", "Refroidir, conserver, réchauffer"⟩,
        category := ⟨"03 · Keep safe", "03 · Conserver"⟩,
        summary := ⟨"Handle leftovers promptly and follow local food-safety guidance.", "Conservez rapidement les restes et suivez les recommandations locales de sécurité alimentaire."⟩,
        body := ⟨"Divide large batches into shallow containers so they cool more quickly, refrigerate promptly and follow the storage guidance for each ingredient. Reheat leftovers until steaming hot throughout, and avoid repeatedly cooling and reheating the same portion. When in doubt about how food has been stored, do not taste-test it; discard it and consult reliable local food-safety advice.", "Répartissez les grandes quantités dans des récipients peu profonds pour accélérer le refroidissement, réfrigérez rapidement et suivez les recommandations de conservation des ingrédients. Réchauffez les restes jusqu'à ce qu'ils soient bien fumants et évitez de refroidir puis réchauffer plusieurs fois la même portion. En cas de doute sur la conservation, ne goûtez pas l'aliment : jetez-le et consultez des conseils locaux fiables de sécurité alimentaire."⟩,
        metadata := ⟨"Kitchen note · Food safety", "Conseil cuisine · Sécurité alimentaire"⟩ }
    ] }
]