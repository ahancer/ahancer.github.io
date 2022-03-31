document.addEventListener('DOMContentLoaded', function() {
  var typed = new Typed('#typed', {
    stringsElement: '#typed-strings',
    typeSpeed: 100,
    backSpeed: 100,
    backDelay: 2000,
    startDelay: 50,
    loop: true,
    loopCount: Infinity,
  });

});

function prettyLog(str) {
  console.log('%c ' + str, 'color: green; font-weight: bold;');
}

function toggleLoop(typed) {
  if (typed.loop) {
    typed.loop = false;
  } else {
    typed.loop = true;
  }
}
