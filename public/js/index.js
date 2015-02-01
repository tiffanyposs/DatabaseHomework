        //ON PAGE LOAD
        //THIS GENERATES EACH ARTIST IMAGE
        //ids: artist_section, artist_img
        var artists = <%= artists %>;
        console.log(artists);

artists.forEach(function(artist){
        var artist_name = artist[1]
        encoded = artist_name.replace(" ", "+");
        console.log(encoded);

        var url = "https://api.spotify.com/v1/search?q=artist:" + encoded + "&type=artist"

        var xhr = new XMLHttpRequest();


    xhr.addEventListener('load', function(e) {
      
        var d = xhr.responseText;
        var parsed = JSON.parse(d);

        var artist_section = document.getElementById('artist_section');

        var artist_img = document.createElement('img');
        artist_img.className = "artist_img";
        artist_img.src = parsed['artists']['items'][0]['images'][0]['url'];
        artist_section.appendChild(artist_img);

        console.log(parsed);
    })
        xhr.open("GET", url);
        xhr.send();
    
}) //end for each