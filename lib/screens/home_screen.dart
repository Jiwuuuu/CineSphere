import 'package:cinesphere/favorites_manager.dart';
import 'package:cinesphere/main.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart'; // Ensure this is correctly defined
import 'package:cinesphere/screens/moviedesc_screen.dart'; // Ensure this is correctly defined
import 'package:cinesphere/screens/favorites_screen.dart'; // Ensure this is correctly defined
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final List<Movie> nowPlayingMovies = [
    Movie(
      title: "The Nun II",
      genre: "Horror",
      releaseYear: "2023",
      director: "Michael Chaves",
      cast: ["Taissa Farmiga", "Storm Reid"],
      MTRCBrating: "SPG",
      description: "1956 - France. A priest is murdered. An evil is spreading. The sequel to the worldwide smash hit follows Sister Irene as she once again comes face-to-face with Valak, the demon nun.",
      imageUrl: "images/The Nun II.jpeg",
      trailerUrl: "https://youtu.be/QF-oyCwaArU?feature=shared",  
    ),
    Movie(
      title: "Coraline",
      genre: "Animation",
      releaseYear: "2023",
      director: "Henry Selik",
      cast: ["Dakota Fanning, Teri Hatcher, John Hodgman"],
      MTRCBrating: "PG",
      description: "A young girl walks through a secret door in her new home and discovers an alternate version of her life. On the surface, this parallel reality is eerily similar to her real life–only much better. But when this wondrously off–kilter, fantastical adventure turns dangerous and her counterfeit parents try to keep her forever, Coraline must count on her resourcefulness, determination, and bravery to save her family and get back home.",
      imageUrl: "images/Coraline.jpeg",
      trailerUrl: "https://youtu.be/T6iQnnHNF50",  
    ),
    Movie(
      title: "I AM STILL",
      genre: "Concert Film",
      releaseYear: "2023",
      director: "JUNSOO PARK",
      cast: ["JUNG KOOK"],
      MTRCBrating: "PG",
      description: "I just follow my own compass.” Jung Kook of BTS, the '21st Century Pop Artist,' ascended to global stardom with his debut solo single 'Seven (feat. Latto)' in July 2023. Achieving unprecedented success, Jung Kook became the first Asian solo artist to top the Billboard HOT 100, Global 200, and Global 200 Excl. US charts. His singles 'Seven,' '3D (feat. Jack Harlow),' and 'Standing Next to You' all reached the top 10 of the Billboard HOT 100, making him the only K-pop solo artist to achieve this feat. His album ‘GOLDEN’ also made history by staying onthe Billboard 200 for 24 consecutive weeks. Through exclusive, unseen interviews and behind-the-scenes footage, alongside electrifying concert performances, this brand new film showcases Jung Kook’s eight-month journey, capturing his unwavering dedication and growth. Join Jung Kook as he shares his remarkable rise to fame and heartfelt moments with ARMY around the world in 'JUNG KOOK: I AM STILL'.",
      imageUrl: "images/I AM STILL.jpeg",
      trailerUrl: "https://youtu.be/T6iQnnHNF50",  
    ),
    Movie(
      title: "MEGALOPOLIS",
      genre: "Drama,Sci-Fi,Epic",
      releaseYear: "2023",
      director: "Francis Ford Coppola",
      cast: ["Adam Driver, Giancarlo Esposito, Nathalie Emmanuel"],
      MTRCBrating: "R-16",
      description: "The city of New Rome is the main conflict between Cesar Catilina, a brilliant artist in favor of a utopian future, and the greedy mayor Franklyn Cicero. Between them is Julia Cicero, her loyalty divided between her father and her beloved.",
      imageUrl: "images/MEGALOPOLIS.jpeg",
      trailerUrl: "https://youtu.be/T6iQnnHNF50",  
    ),
    // Add more movies here as per your requirement
  ];

  final List<Movie> upcomingMovies = [
    Movie(
      title: "Harold and the Purple Crayon",
      genre: "Animation",
      releaseYear: "2023",
      director: "Carla Marsh",
      cast: ["Zach Tyler", "Lacey Chabert"],
      MTRCBrating: "PG",
      description: "Based on the beloved children's book series, this film follows Harold's imaginative adventures.",
      imageUrl: "images/Harold and the Purple Crayon.jpeg",
      trailerUrl: "https://www.youtube.com/watch?v=trailer_id2", 
    ),
    Movie(
      title: "Transformers One",
      genre: "Action",
      releaseYear: "2024",
      director: "Steven Caple Jr.",
      cast: ["Anthony Ramos", "Dominique Fishback"],
      MTRCBrating: "PG",
      description: "The next installment in the Transformers franchise, featuring new characters and explosive action.",
      imageUrl: "images/Transformers One.jpeg",
      trailerUrl: "https://www.youtube.com/watch?v=trailer_id4",
    ),
    Movie(
      title: "VENOM: THE LAST DANCE",
      genre: "Action,Adventure,Sci-Fi",
      releaseYear: "2024",
      director: "Kelly Marcel",
      cast: ["Tom Hardy, Rhys Ifans, Juno Temple"],
      MTRCBrating: "NYR",
      description: "Eddie and Venom are on the run. Hunted by both of their worlds and with the net closing in, the duo are forced into a devastating decision that will bring the curtains down on Venom and Eddie's last dance.",
      imageUrl: "images/VENOM THE LAST DANCE.jpeg",
      trailerUrl: "https://youtu.be/__2bjWbetsA",
    ),
    Movie(
      title: "RED ONE",
      genre: "Comedy,Action,Adventure",
      releaseYear: "2024",
      director: "Jake Kasdan",
      cast: ["Dwayne Johnson, Chris Evans, Lucy Liu"],
      MTRCBrating: "PG",
      description: "After Santa Claus (code name: Red One) is kidnapped, the North Pole's Head of Security (Dwayne Johnson) must team up with the world's most infamous bounty hunter (Chris Evans) in a globe-trotting, action-packed mission to save Christmas.",
      imageUrl: "images/RED ONE.jpeg",
      trailerUrl: "https://youtu.be/U8XH3W0cMss",
    ),
    // Add more movies here as per your requirement
  ];

  final List<Movie> advanceSellingMovies = [
    Movie(
      title: "UnHappy For You",
      genre: "Drama, Romance",
      releaseYear: "2023",
      director: "Petersen Vargas",
      cast: ["Joshua Garcia, Julia Barretto, Nonie Buencamino"],
      MTRCBrating: "PG",
      description: "The comeback film of JoshLia (Joshua Garcia and Julia Barretto) is about how ex-lovers navigate feelings of anguish and deep affection with someone who once held a special place in their hearts.",
      imageUrl: "images/UnHappy For You.jpeg",
      trailerUrl: "https://www.youtube.com/watch?v=trailer_id3", 
    ),
    Movie(
      title: "HELLO LOVE AGAIN",
      genre: "Drama,Romance",
      releaseYear: "2024",
      director: "Cathy Garcia-Sampana",
      cast: ["Kathryn Bernardo, Alden Richards"],
      MTRCBrating: "NYR",
      description: "After 5 years apart, Joy and Ethan say their hellos once more. As they rediscover each other, they navigate the complexities of their new lives in Canada , finding romance and connection amidst changes.",
      imageUrl: "images/HELLO LOVE AGAIN.jpeg",
      trailerUrl: "https://youtu.be/-mjQJB9oSe4?feature=shared", 
    ),
    Movie(
      title: "JOKER: FOLIE A DEUX",
      genre: "Thriller,Drama,Crime",
      releaseYear: "2024",
      director: "Todd Phillips",
      cast: ["Joaquin Phoenix, Lady Gaga, Brendan Gleeson"],
      MTRCBrating: "R-16",
      description: "Failed comedian Arthur Fleck meets the love of his life, Harley Quinn, while in Arkham State Hospital. Upon release, the pair embark on a doomed romantic misadventure.",
      imageUrl: "images/JOKER FOLIE A DEUX.jpeg",
      trailerUrl: "https://youtu.be/-mjQJB9oSe4?feature=shared", 
    ),
    Movie(
      title: "BAD GENIUS (2024)",
      genre: "Thriller",
      releaseYear: "2024",
      director: "J.C. Lee",
      cast: ["Benedict Wong, Callina Liang, Jabari Banks"],
      MTRCBrating: "PG",
      description: "A group of seniors of an entrepreneurial high school team up to take down a rigged college admissions system.",
      imageUrl: "images/BAD GENIUS (2024).jpeg",
      trailerUrl: "https://youtu.be/HqKJvvpeuAY", 
    ),
    // Add more movies here as per your requirement
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_color,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "CS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 50, 48, 48)),
                  prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategorySection("Now Showing", nowPlayingMovies, context),
            _buildCategorySection("Advance Selling", advanceSellingMovies, context),
            _buildCategorySection("Coming Soon", upcomingMovies, context),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.favorite_outline, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              onPressed: () {
                // No need to push, just refresh the current screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {
                // Implement notifications functionality if needed
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<Movie> movies, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lexendDeca(
              color: header_text,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),  
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDescScreen(movie: movies[index]),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              movies[index].imageUrl,
                              height: 180,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            movies[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            movies[index].genre,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),                   
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}