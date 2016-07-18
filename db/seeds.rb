# Should have 9 users after every seed
users = [{email: "grea@fake.com", username: "iceman", password: "test"},
  {email: "mav@fake.com", username: "maverick", password: "test"},
  {email: "chief@fake.com", username: "john", password: "test"},
  {email: "drake@fake.com", username: "musicman", password: "test"},
  {email: "dance@fake.com", username: "smooth", password: "test"},
  {email: "test@fake.com", username: "test", password: "test"},
  {email: "moses@fake.com", username: "mose", password: "test"},
  {email: "shino@fake.com", username: "shino", password: "test"},
  {email: "troy@fake.com", username: "troy", password: "test"}]

books = [
      {
      user_id: 7,
      title: "The Five People You Meet in Heaven",
      author: "Mitch Albom",
      genre: "Fiction",
      available: false
   },
      {
      user_id: 3,
      title: "The Hunger Games",
      author: "Suzanne Collins",
      genre: "Fiction",
      available: true
   },
      {
      user_id: 7,
      title: "Game of Thrones",
      author: "George R.R. Martin",
      genre: "Fiction",
      available: false
   },
      {
      user_id: 3,
      title: "Pride and Prejudice",
      author: "Jane Austen",
      genre: "History",
      available: true
   },
      {
      user_id: 6,
      title: "The Hobbit",
      author: "J.R.R Tolkien",
      genre: "Fantasy",
      available: true
   },
      
      {
      user_id: 6,
      title: "To Kill a Mockingbird",
      author: "Harper Lee",
      genre: "Horror",
      available: true
   },
      {
      user_id: 1,
      title: "The Art of War",
      author: "Sun Tzu",
      genre: "Action",
      available: true
   },
      {
      user_id: 7,
      title: "The Alchemist",
      author: "Paolo Coelho",
      genre: "Action",
      available: false
   }
]

posts = [
      {
      user_id: 2,
      book_id: 7,
      rating: 5,
      review: "Lorem ipsum nulla parturient tortor duis accumsan placerat rutrum luctus vitae est. Lorem ipsum dis, diam curabitur dignissim pulvinar urna imperdiet sociis sociis consequat! Lorem ipsum hac augue scelerisque blandit tortor class suspendisse neque lectus integer. Lorem ipsum semper, tortor ornare parturient lacinia taciti hac rutrum interdum vestibulum! Lorem ipsum vehicula nec augue donec phasellus dictum leo himenaeos eleifend vestibulum. \\nLobortis aliquam mollis dui interdum urna fames sociosqu vel. Quisque sollicitudin etiam senectus vel euismod sed nibh volutpat? Taciti ridiculus nibh vel consequat praesent lectus non nibh. Suspendisse sed accumsan enim leo sodales elit integer lobortis? \\n"
   },
      {
      user_id: 6,
      book_id: 1,
      rating: 2,
      review: "Lorem ipsum sit vulputate aliquet quam class facilisi feugiat cum. Lorem ipsum nam tincidunt proin dictum facilisi sollicitudin quam taciti? Lorem ipsum nascetur faucibus cubilia lacus lacus placerat vivamus senectus. Lorem ipsum pellentesque netus parturient dignissim congue velit ad imperdiet. Lorem ipsum fermentum eros adipiscing, tempor dictum lacus dictumst eu. Lorem ipsum tincidunt nam iaculis habitant lacus, vulputate nam aliquet! \\nId porta justo lectus magnis enim mus viverra? Natoque interdum at porttitor nostra eget sapien fermentum. Potenti amet luctus vel id dolor habitant nam. Sagittis facilisi quis amet pulvinar, aptent sapien quam. Euismod nam hac erat hendrerit fames orci tellus. Quis lectus euismod nullam dictumst neque ante class. \\n"
   },
      {
      user_id: 9,
      book_id: 3,
      rating: 5,
      review: "Lorem ipsum rutrum duis luctus, convallis turpis neque arcu accumsan eleifend? Lorem ipsum vel iaculis lobortis maecenas fringilla tellus torquent venenatis egestas. Lorem ipsum nunc fames, habitant dolor a lacinia commodo netus lorem. Lorem ipsum adipiscing vulputate tristique dis massa, lacinia aliquam posuere neque? Lorem ipsum iaculis sagittis suspendisse est conubia dictumst risus dignissim sociosqu? \\nMagna ad dis morbi, auctor et mi iaculis laoreet turpis eros. Nullam magna donec vehicula per fusce a torquent lobortis sed semper. \\n"
   },
      {
      user_id: 1,
      book_id: 1,
      rating: 3,
      review: "Lorem ipsum mus maecenas donec ultrices habitasse lacus dictumst potenti cum. Lorem ipsum elementum interdum nulla lectus turpis et in ridiculus aliquet! Lorem ipsum ridiculus facilisi sem litora fermentum eros sem lobortis netus. Lorem ipsum nostra proin velit nibh sed sit eu porta suscipit. \\nTortor eu mattis rutrum odio diam iaculis arcu. Nostra malesuada pulvinar class tempor augue dapibus mus. Morbi odio varius lacinia leo cras nullam suspendisse. Sollicitudin arcu, elit dapibus faucibus arcu tristique augue. Arcu cum vulputate imperdiet, aenean tincidunt bibendum penatibus. \\n"
   },
      {
      user_id: 9,
      book_id: 7,
      rating: 4,
      review: "Lorem ipsum massa vehicula sed et quam condimentum convallis taciti primis felis magna. Lorem ipsum quis duis feugiat felis primis semper at cursus tellus id amet! Lorem ipsum volutpat suscipit nam nam tortor habitasse dui odio facilisis etiam metus. Lorem ipsum feugiat dui lorem nec viverra a lacus, donec tortor diam curae;? \\nNullam tempus commodo dis tincidunt tristique ac, tellus netus venenatis. Praesent velit nisl amet leo id ultrices amet adipiscing cras. Ad vivamus vivamus, primis ultricies pretium suscipit duis ridiculus ac. \\n"
   },
      {
      user_id: 9,
      book_id: 8,
      rating: 4,
      review: "Lorem ipsum diam dictumst dignissim porttitor in aliquam ligula erat gravida praesent pellentesque. Lorem ipsum iaculis sociosqu felis augue ut cursus quisque gravida, elit sollicitudin vivamus. Lorem ipsum cubilia enim nulla sollicitudin dis lectus ultricies nostra et litora egestas. Lorem ipsum sociosqu ornare ipsum nullam, nullam lacinia lectus ullamcorper non enim vehicula? \\nEros molestie litora primis per nascetur morbi inceptos feugiat. Congue curabitur nascetur fringilla porta sed, hendrerit taciti gravida. Tincidunt fermentum eu purus duis suscipit vivamus nisi suspendisse? Orci ligula vivamus auctor feugiat primis donec augue proin? \\n"
   },
      {
      user_id: 8,
      book_id: 2,
      rating: 4,
      review: "Lorem ipsum ultrices neque ante nam diam litora condimentum diam lobortis velit. Lorem ipsum quis porttitor venenatis, aliquam vehicula sociosqu congue sed nunc id. \\nDiam phasellus ornare metus pretium dis libero dapibus cursus. Luctus dapibus nullam penatibus suspendisse nisl per pharetra rutrum. Posuere mus maecenas ipsum faucibus ac ut elementum vivamus. Suscipit dis magna maecenas aliquam lorem aliquam taciti rhoncus. Parturient magnis, mauris adipiscing ullamcorper pretium iaculis tempor hac. \\n"
   },
      {
      user_id: 1,
      book_id: 2,
      rating: 5,
      review: "Lorem ipsum diam senectus nunc consequat diam quisque viverra sed mollis. Lorem ipsum sapien cursus velit tincidunt rhoncus fermentum rutrum suscipit nullam? Lorem ipsum per, purus lacinia ornare porta risus consectetur mollis auctor. \\nAt nec velit cursus lobortis mauris condimentum hac massa lectus mauris. Cursus blandit ullamcorper porta turpis accumsan libero orci hac primis metus. Feugiat vivamus volutpat urna lorem etiam sagittis hendrerit lorem iaculis suspendisse! Nec nisi vel aptent facilisi non integer ultrices eleifend est sollicitudin? \\n"
   },
      {
      user_id: 4,
      book_id: 7,
      rating: 5,
      review: "Lorem ipsum facilisis malesuada potenti arcu velit vitae mi sociis torquent elementum posuere netus? Lorem ipsum consectetur consectetur sem laoreet rhoncus sed feugiat platea pulvinar et himenaeos elementum. Lorem ipsum risus conubia at nunc, aenean viverra porta dignissim felis volutpat sit tempus. Lorem ipsum nascetur donec tellus mattis curabitur gravida parturient quisque mattis ad rhoncus ligula! Lorem ipsum iaculis neque nulla mollis convallis justo et nisi amet, tortor nunc dictumst. Lorem ipsum cum sociis libero condimentum rhoncus leo in leo odio at semper integer! \\nSuspendisse eleifend felis torquent aliquet in quam consequat egestas pharetra. Placerat ligula integer eget nostra litora quis hac class tellus. Egestas scelerisque viverra ultricies auctor commodo rutrum sollicitudin massa sociosqu. \\n"
   }
]

pictures = [
      {
      book_id: 1,
      url: "http://d.gr-assets.com/books/1388200541l/3431.jpg"
   },
      {
      book_id: 2,
      url: "http://static.oprah.com/images/o2/201503/201503-book-hunger-games-949x1356.jpg"
   },
      {
      book_id: 3,
      url: "http://vignette1.wikia.nocookie.net/iceandfire/images/b/b6/Game_of_thrones.jpeg/revision/latest?cb=20130302001049"
   },
      {
      book_id: 4,
      url: "http://www.publicbookshelf.com/images/PridePrejudice423x630.jpg"
   },
      {
      book_id: 5,
      url: "https://upload.wikimedia.org/wikipedia/en/3/30/Hobbit_cover.JPG"
   },
      {
      book_id: 6,
      url: "https://upload.wikimedia.org/wikipedia/en/7/79/To_Kill_a_Mockingbird.JPG"
   },
      {
      book_id: 7,
      url: "http://www.freebooks.com/wp-content/uploads/2013/04/The-Art-of-War.jpg"
   },
      {
      book_id: 8,
      url: "http://prodimage.images-bn.com/pimages/9780062315007_p0_v2_s192x300.jpg"
   },
      {
      book_id: 9,
      url: "http://d.gr-assets.com/books/1388200541l/3431.jpg"
   }
]

users.each do |user|
  User.create(user)
end

books.each do |book|
  Book.create(book)
end

posts.each do |post|
  Post.create(post)
end

pictures.each do |picture|
  Picture.create(picture)
end