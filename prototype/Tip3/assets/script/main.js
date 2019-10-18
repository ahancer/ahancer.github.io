$(function() {

    if( $(window).outerWidth() <= 1024 ) {
        $("#modal-tutorial").modal();
    }

    jQuery().mmenu && $("#mobilenav").mmenu({
        navbar: {
            title: "Menu"
        },
        dropdown: {
            drop: !0,
            tip: !1
        }
    }, {
        clone: !1,
        dropdown: {
            offset: {
                button: {
                    x: "right",
                    y: 10
                }
            }
        }
    }), $(".dropdown-menu a.dropdown-toggle").on("click", function() {
        return $(this).next().hasClass("show") || $(this).parents(".dropdown-menu").first().find(".show").removeClass("show"), $(this).next(".dropdown-menu").toggleClass("show"), $(this).parents("li.nav-item.dropdown.show").on("hidden.bs.dropdown", function() {
            $(".dropdown-submenu .show").removeClass("show")
        }), !1
    }), $(".trip-for .multipax").on("click", function() {
        !0 !== $(this).hasClass("active") && ($("#multipax-field").removeClass("u--display--none"), $("#family-field").addClass("u--display--none"))
    }), $(".trip-for .family").on("click", function() {
        !0 !== $(this).hasClass("active") && ($("#family-field").removeClass("u--display--none"), $("#multipax-field").addClass("u--display--none"))
    }), $(".trip-for .individual").on("click", function() {
        !0 !== $(this).hasClass("active") && ($("#family-field").addClass("u--display--none"), $("#multipax-field").addClass("u--display--none"))
    }), $("#ta-getquote .input-daterange").datepicker({
        format: "dd/mm/yyyy",
        startDate: "today",
        autoclose: !0,
        templates: {
            leftArrow: "&#10229;",
            rightArrow: "&#10230;"
        }
    }), jQuery().owlCarousel && ($(".testimonials-carousel").owlCarousel({
        items: 1.5,
        loop: !0,
        dots: !1,
        nav: !1,
        margin: 15,
        responsiveClass: !0,
        responsive: {
            767: {
                items: 3,
                dots: !1,
                nav: !0
            },
            991: {
                items: 4,
                dots: !0,
                dotsEach: !0,
                nav: !0
            }
        },
        navText: ["<span class='arrow-left'></span>", "<span class='arrow-right'></span>"]
    }), $(".promotion-carousel").owlCarousel({
        items: 1.5,
        loop: !0,
        dots: !1,
        nav: !1,
        margin: 15,
        responsiveClass: !0,
        responsive: {
            767: {
                items: 1.5,
                dots: !0,
                dotsEach: !0,
                nav: !0
            },
            991: {
                items: 1.5,
                dots: !0,
                dotsEach: !0,
                nav: !0
            }
        },
        navText: ["<span class='arrow-left'></span>", "<span class='arrow-right'></span>"]
    }), $(".articles-carousel").owlCarousel({
        autoplay: !0,
        items: 1,
        loop: !0,
        dots: !0,
        nav: !0,
        margin: 15,
        responsiveClass: !0,
        responsive: {
            767: {
                items: 3,
                dots: !0,
                nav: !0
            },
            991: {
                items: 3,
                dots: !0,
                dotsEach: !0,
                nav: !0,
                margin: 10
            }
        },
        navText: ["<span class='arrow-left'></span>", "<span class='arrow-right'></span>"]
    }), $(".package-carousel").owlCarousel({
        items: 1.3,
        // items: 1,
        loop: false,
        dots: !1,
        nav: !1,
        margin: 15,
        responsiveClass: !0,
        rewind: false,
        responsive: {
            0: {
                // items: 2.5,
                items: 1,
                dots: !1,
                nav: !1,
                stagePadding: 50
            },
            768: {
                // items: 3.5,
                items: 2,
                dots: !1,
                nav: !1,
                stagePadding: 50
            },
            992: {
                items: 3,
                dots: !1,
                nav: !1,
                stagePadding: 80
            },
            1200: {
                // items: 4.5,
                items: 3,
                dots: !1,
                nav: !0,
                stagePadding: 100
            },
            1600: {
                items: 4,
                dots: !1,
                nav: !0,
                stagePadding: 200
            }
        },
        navText: ["<span class='arrow-left'></span>", "<span class='arrow-right'></span>"]
    })), $(".selectpicker").selectpicker({}), $("input#id").on("click", function() {
        !0 === $(this).prop("checked") && ($("input#id-field").removeClass("u--display--none"), $("input#passport-field").addClass("u--display--none"))
    }), $("input#passport").on("click", function() {
        !0 === $(this).prop("checked") && ($("input#passport-field").removeClass("u--display--none"), $("input#id-field").addClass("u--display--none"))
    }), $("input#other").on("click", function() {
        !0 === $(this).prop("checked") && $("#other-field").removeClass("u--display--none")
    }), $("input#legal").on("click", function() {
        !0 === $(this).prop("checked") && $("#other-field").addClass("u--display--none")
    }), $("input#id-2").on("click", function() {
        !0 === $(this).prop("checked") && ($("input#id-field-2").removeClass("u--display--none"), $("input#passport-field-2").addClass("u--display--none"))
    }), $("input#passport-2").on("click", function() {
        !0 === $(this).prop("checked") && ($("input#passport-field-2").removeClass("u--display--none"), $("input#id-field-2").addClass("u--display--none"))
    }), $("input#other-2").on("click", function() {
        !0 === $(this).prop("checked") && $("#other-field-2").removeClass("u--display--none")
    }), $("input#legal-2").on("click", function() {
        !0 === $(this).prop("checked") && $("#other-field-2").addClass("u--display--none")
    }), $('input[name="objective-type"]').on("click", function() {
        $("#other-objective-field").addClass("u--display--none"), !0 === $("input#other-objective").prop("checked") && $("#other-objective-field").removeClass("u--display--none")
    }), $('[data-toggle="tooltip"]').tooltip();
    var a, e, t = 0;

    function s(a) {
        $(a).hasClass("is--visible") ? $(a).removeClass("is--visible") : $(a).addClass("is--visible")
    }
    $(".btn-group-toggle").on("click", function() {
        var i = $(this).data("package"),
            o = $(this).data("price");
        $(this).children(".btn").hasClass("active") ? (t -= 1, function(t) {
            a === t ? ($(".compare-item.item-1").empty(), $(".compare-item.item-1").attr("data-package", ""), $(".compare-item.item-1").attr("data-price", ""), a = "") : e === t && ($(".compare-item.item-2").empty(), $(".compare-item.item-2").attr("data-package", ""), $(".compare-item.item-2").attr("data-price", ""), e = "")
        }(i), 0 === t ? $(".compare-canvas").removeClass("is--visible") : 1 === t && ($(".compare-canvas .btn-cancel").addClass("is--active"), $(".compare-canvas .btn-compare").removeClass("is--active"))) : 1 === (t += 1) ? (s(".compare-canvas"), a || ($(".compare-item.item-1").attr("data-package", i), $(".compare-item.item-1").attr("data-price", o), $(".compare-item.item-1").append(i + "<span>" + o + " บาท</span><i></i>"), a = i), $(".compare-canvas .btn-cancel").addClass("is--active"), $(".compare-canvas .btn-compare").removeClass("is--active")) : 2 === t ? (a ? ($(".compare-item.item-2").attr("data-package", i), $(".compare-item.item-2").attr("data-price", o), $(".compare-item.item-2").append(i + "<span>" + o + " บาท</span><i></i>"), e = i) : ($(".compare-item.item-1").attr("data-package", i), $(".compare-item.item-1").attr("data-price", o), $(".compare-item.item-1").append(i + "<span>" + o + " บาท</span><i></i>"), a = i), $(".compare-canvas .btn-compare").addClass("is--active"), $(".compare-canvas .btn-cancel").removeClass("is--active")) : ($(this).children(".btn").toggleClass("active"), $(this).removeClass("selected"), t = 2)
    }), $(".compare-canvas .btn-cancel").on("click", function() {
        return $(".compare-canvas").removeClass("is--visible"), $(".btn-group-toggle").children(".btn").removeClass("active"), $(".compare-item.item-2, .compare-item.item-1").empty(), $(".compare-item.item-2, .compare-item.item-1").attr("data-package", ""), $(".compare-item.item-2, .compare-item.item-1").attr("data-price", ""), t = 0, a = "", e = "", !1
    }), $(".compare-canvas .compare-item").delegate("i", "click", function() {
        var s = $(this).parent().data("package"),
            i = $(this).parent().data("price");
        t -= 1, $('.btn-group-toggle[data-package="' + s + '"][data-price="' + i + '"]').children(".btn").removeClass("active"), 0 === t ? $(".compare-canvas").removeClass("is--visible") : 1 === t && ($(".compare-canvas .btn-cancel").addClass("is--active"), $(".compare-canvas .btn-compare").removeClass("is--active")), $(this).parent().hasClass("item-1") ? ($(".compare-item.item-1").empty(), $(".compare-item.item-1").attr("data-package", ""), $(".compare-item.item-1").attr("data-price", ""), a = "") : ($(".compare-item.item-2").empty(), $(".compare-item.item-2").attr("data-package", ""), $(".compare-item.item-2").attr("data-price", ""), e = "")
    }), $(".show-canvas").on("click", function(a) {
        s("." + $(this).data("canvas-position") + ".canvas"), a.preventDefault()
    }), $(".hide-canvas").on("click", function() {
        var a = $(this).data("canvas-position");
        $("." + a + ".canvas").removeClass("is--visible")
    })
});