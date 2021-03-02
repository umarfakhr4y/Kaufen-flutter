// new ConstrainedBox(
//           child: FutureBuilder<Map<String, dynamic>>(
//             future: getData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return new Swiper(
//                     itemBuilder: (BuildContext context, int index) {
//                       return new Image.network(
//                         "http://mysite.go.id/wp/gambar_iklan/" +
//                             snapshot.data.data[index].gambar_iklan,
//                         fit: BoxFit.fitWidth,
//                       );
//                     },
//                     itemCount: snapshot.data.length,
//                     viewportFraction: 0.8,
//                     autoplay: true,
//                     scale: 0.9,
//                     itemHeight: MediaQuery.of(context).size.width / 6);
//               } else {
//                 return new CircularProgressIndicator();
//               }
//             },
//           ),