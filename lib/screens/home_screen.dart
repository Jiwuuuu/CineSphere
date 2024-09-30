import 'package:cinesphere/favorites_manager.dart';
import 'package:flutter/material.dart';
import 'package:cinesphere/screens/movie.dart'; // Ensure this is correctly defined
import 'package:cinesphere/screens/moviedesc_screen.dart'; // Ensure this is correctly defined
import 'package:cinesphere/screens/favorites_screen.dart'; // Ensure this is correctly defined

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
      description: "I just follow my own compass.” Jung Kook of BTS, the '21st Century Pop Artist,' ascended to global stardom with his debut solo single 'Seven (feat. Latto)' in July 2023. Achieving unprecedented success, Jung Kook became the first Asian solo artist to top the Billboard HOT 100, Global 200, and Global 200 Excl. US charts. His singles 'Seven,' '3D (feat. Jack Harlow),' and 'Standing Next to You' all reached the top 10 of the Billboard HOT 100, making him the only K-pop solo artist to achieve this feat. His album ‘GOLDEN’ also made history by staying on the Billboard 200 for 24 consecutive weeks. Through exclusive, unseen interviews and behind-the-scenes footage, alongside electrifying concert performances, this brand new film showcases Jung Kook’s eight-month journey, capturing his unwavering dedication and growth. Join Jung Kook as he shares his remarkable rise to fame and heartfelt moments with ARMY around the world in 'JUNG KOOK: I AM STILL'.",
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
      imageUrl: "images/BAD GENIUS 2024.jpeg",
      trailerUrl: "https://www.youtube.com/watch?v=trailer_id3", 
    ),
    // Add more movies here as per your requirement
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CineSphere"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SectionTitle(title: "Now Playing"),
            MovieList(movies: nowPlayingMovies),
            SectionTitle(title: "Upcoming Movies"),
            MovieList(movies: upcomingMovies),
            SectionTitle(title: "Advance Selling Movies"),
            MovieList(movies: advanceSellingMovies),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDescScreen(movie: movie),
                ),
              );
            },
            child: Container(
              width: 150,
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(movie.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
