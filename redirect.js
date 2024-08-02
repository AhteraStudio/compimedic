// redirect.js
(function() {
    var path = window.location.pathname;
    if (path.endsWith('.html')) {
        var newPath = path.replace('.html', '');
        window.location.replace(newPath);
    }
})();