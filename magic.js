(function(){
  // Mark that JS is working:
  document.body.classList.remove('no-js');
  document.body.classList.add('yes-js');

  // Load search data if available
  const searchDataContainer = document.getElementById('search-data');
  if(searchDataContainer){
    const searchData = JSON.parse(searchDataContainer.textContent);
    const searchBox = document.getElementById('search');
    const searchResults = document.getElementById('search-results');

    function runSearch(){
      const searchTerm = searchBox.value.trim().toLowerCase();
      if(searchTerm.length < 2){
        searchResults.innerHTML = '';
      } else {
        const results = searchData.filter(icon => icon.short.match(searchTerm)).slice(0, 64);;
        searchResults.innerHTML = results.map(icon => `
          <li class="icon">
            <a class="icon-link" href="${icon.name}" title="${icon.short}">
              <span class="icon-img">
                <img src="${icon.name}" width="${icon.size[0]}" height="${icon.size[1]}">
              </span>
              <span class="icon-size">${icon.size[0]}x${icon.size[1]}</span>
            </a>
            <a class="icon-page-link" href="icons/${icon.page}.html">Page ${icon.page}</a>
          </li>
        `).join('');
      }
    }

    searchBox.addEventListener('change', runSearch);
    searchBox.addEventListener('keyup', runSearch);
    runSearch();
  }
})();
