$(document).ready(function () {
    let show = 'none';
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "OpenMDT":
                $('.tablet-all').show();
                $(".holder").show();
                $(".avatar").hide();
                $(".nav-user").hide();
                $(".default-content").hide();
                setTimeout(function() {
                    $(".holder").fadeOut(700);
                    $(".avatar").fadeIn(700);
                    $(".nav-user").fadeIn(700);
                    $(".default-content").fadeIn(700);
                }, 3000);
            break;
            case "SendMDTdata":
                let data = event.data.mdtdata;
                $('.default-duty-info-box').empty();
                $('.announcements-content-undermenu').empty();
                $('.raport-content-undermenu').empty();
                $('#Podstawowe_badania, #Badania_specjalistyczne, #Operacje_i_Zabiegi, #Hospitalizacja, #Kursy').empty();
                $('#car-counter').html(data.vehCount);
                $('#people-counter').html(data.charCount);
                $('#week-counter').html(data.fakturyTydzien);
                $('#week-month').html(data.fakturyMiesiac);
                $('#name').html(data.Player.firstname + " " + data.Player.lastname);
                $('#grade').html(data.Player.job.grade_label);
                $('#note-textbox').val(data.Notepad);
                if(data.Player.job.grade_name == "boss") {
                    $("#announce_textbox").prop("readonly", false); 
                    $('.boss-column').show();
                    show = 'block';
                } else {
                    $("#announce_textbox").prop("readonly", true); 
                    $('.boss-column').hide();
                    show = 'none';
                }
                for (let key in data.Ambulance) {
                    let status = 'Nie';
                    if(data.Ambulance[key].duty_status != null) {
                        if(data.Ambulance[key].duty_status == 1) {
                            status = 'Nie'
                        } else if(data.Ambulance[key].duty_status == 2) {
                            status = 'Tak'
                        }
                    }
                    $('#onduty-info').append(
                        `<div class='default-duty-info' style='margin-top: 8px;'>
                            <div class='duty-who'>${data.Ambulance[key].firstname + ' ' + data.Ambulance[key].lastname}</div>
                            <div class="duty-number">${data.Ambulance[key].phone_number}</div>
                            <div class="duty-online">
                                <div class="duty-yes"><span style="color: ${data.Ambulance[key].color};">${status}</span></div>
                            </div>
                        </div>`
                    )
                }
                for (let key in data.OstatnieFaktury) {
                    $('#ostatniefaktury-info').append(
                        `<div class="default-duty-info" style="margin-top: 8px; text-align: center;">
                            <div class="default-fineid">#${data.OstatnieFaktury[key].id}</div>
                            <div class="default-person">${data.OstatnieFaktury[key].patient}</div>
                            <div class="default-date">${new Date(data.OstatnieFaktury[key].date).toLocaleDateString("pl-PL")}</div>
                            <div class="default-officer">${data.OstatnieFaktury[key].doctor}</div>
                            <div class="default-fine">${data.OstatnieFaktury[key].fee}$</div>
                        </div>`
                    )
                }
                for (let key in data.Ogloszenia) {
                    $('.announcements-content-undermenu').append(
                        `<div class="announcements-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                            <div id="announcements-content-reason" style="width: 43%;">${data.Ogloszenia[key].ogloszenie}</div>
                            <div id="announcements-content-fine" style="width: 20%;">${data.Ogloszenia[key].fp}</div>
                            <div id="announcements-content-date" style="width: 20%;">${new Date(data.Ogloszenia[key].date).toLocaleDateString("pl-PL")}</div>
                            <div id="announcements-content-remove" style="width: 5%; display: ${show};"><i class="far fa-trash-alt"></i></div>
                        </div>`
                    )
                }
                for (let key in data.Raporty) {
                    $('.raport-content-undermenu').append(
                        `<div class="raport-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                            <div id="raport-content-reason" style="width: 43%;">${data.Raporty[key].raport}</div>
                            <div id="raport-content-fine" style="width: 20%;">${data.Raporty[key].fp}</div>
                            <div id="raport-content-date" style="width: 20%;">${new Date(data.Raporty[key].date).toLocaleDateString("pl-PL")}</div>
                            <div id="raport-content-remove" style="width: 5%; display: ${show};"><i class="far fa-trash-alt"></i></div>
                        </div>`
                    )
                }
                for (let key in data.Taryfikator) {
                    for (let key2 in data.Taryfikator[key]) {
                        $(`#${key.replace(/\s+/g,"_")}`).append(
                            `<div class="tariff-holder">
                                <div class="tariff-holder-title">${key2}</div>
                                <div class="tariff-holder-fee" style="width: 100%">
                                    <div id="tariff-grzywna" data-grzywna="${data.Taryfikator[key][key2]["Ticket min"]}" class="tariff-holder-title">Koszt: $${data.Taryfikator[key][key2]["Ticket min"]}</div>
                                </div>
                            </div>`
                         )
                    }
                }
            break;
        }
    })
    let array = [];
    $(document).on("click", ".tariff-holder", function (event) {
        if(!$(".tariff-input").is(':focus')){
            const title = $(this).children(".tariff-holder-title").html()
            const koszt = $(this).children('.tariff-holder-fee').children('#tariff-grzywna').data("grzywna");

            const tariff_cost = parseInt($('#tariff-cost').html());

            let index = -1;
            for (let key in array) {
                if(array[key].title == title) {
                    index = key
                }
            }
            if(index != -1) {
                array[index].value++
                $('.tariff-counter-text').html("");
                for (let key in array) {
                    $('.tariff-counter-text').append("x" + array[key].value + " " + array[key].title + ", ");
                }
            } else {
                var temparray = {
                    title: title,
                    value: 1
                }
                array.push(temparray)
                $('.tariff-counter-text').append("x" + 1 + " " + title + ", ");
            }
            $('#tariff-cost').html(tariff_cost + koszt);
        }   
    });

    $('.tariff-clear-button').on('click', function(){
        $('#tariff-cost').html(0);
        $('.tariff-counter-text').html("");
        array = [];
    })

    $('.tariff-copy-button').on('click', function(){
        const text = $('.tariff-counter-text').html();
        copyToClipboard(text);
    })

    function copyToClipboard(text) {
        var sampleTextarea = document.createElement("textarea");
        document.body.appendChild(sampleTextarea);
        sampleTextarea.value = text; 
        sampleTextarea.select(); 
        document.execCommand("copy");
        document.body.removeChild(sampleTextarea);
    }

    $('#wystaw-faktura-button').on('click', function(){
        const id = $('#fakturaPlayer').val();
        const fee = $('#fee-faktura').val();
        const text = $('#text-faktura').val();
        if(fee != "" && text != "") {
            $('#fee-faktura').val("");
            $('#text-faktura').val("");
            $.post('http://esx_emsmdt/WystawFakture', JSON.stringify({id: id.split('[').pop().split(']')[0], fee: fee, text: text}));
        }
    })

    $('#send_announce').on('click', function(){
        const text = $('#announce_textbox').val();
        $('#announce_textbox').val("");
        $.post('http://esx_emsmdt/SendAnnounce', JSON.stringify({text: text}), function(announcedata){
            $('.announcements-content-undermenu').append(
                `<div class="announcements-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                    <div id="announcements-content-reason" style="width: 43%;">${announcedata.text}</div>
                    <div id="announcements-content-fine" style="width: 20%;">${announcedata.owner}</div>
                    <div id="announcements-content-date" style="width: 20%;">${new Date(announcedata.date*1000).toLocaleDateString("pl-PL")}</div>
                    <div id="announcements-content-remove"><i class="far fa-trash-alt"></i></div>
                </div>`
            )
        })
    })

    $('#send_raport').on('click', function(){
        const text = $('#raport_textbox').val();
        $('#raport_textbox').val("");
        $.post('http://esx_emsmdt/SendRaport', JSON.stringify({text: text}), function(raportdata){
            $('.raport-content-undermenu').append(
                `<div class="raport-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                    <div id="raport-content-reason" style="width: 43%;">${raportdata.text}</div>
                    <div id="raport-content-fine" style="width: 20%;">${raportdata.owner}</div>
                    <div id="raport-content-date" style="width: 20%;">${new Date(raportdata.date*1000).toLocaleDateString("pl-PL")}</div>
                    <div id="raport-content-remove" style="width: 5%; display: ${show};"><i class="far fa-trash-alt"></i></div>
                </div>`
            )
        })
    })

    $(document).on ("click", "#announcements-content-remove", function () {
        const owner = $(this).parent().children("#announcements-content-fine").html();
        const text = $(this).parent().children("#announcements-content-reason").html();
        $.post('http://esx_emsmdt/RemoveAnnounce', JSON.stringify({fp: owner, ogloszenie: text}));
        $(this).parent().fadeOut(500);
    });

    $(document).on ("click", "#raport-content-remove", function () {
        const owner = $(this).parent().children("#raport-content-fine").html();
        const text = $(this).parent().children("#raport-content-reason").html();
        $.post('http://esx_emsmdt/RemoveRaport', JSON.stringify({fp: owner, raport: text}));
        $(this).parent().fadeOut(500);
    });

    $(document).on ("click", "#file-content-removefaktura", function() {
        const id = $(this).parent().data("id");
        const identifier = $("#file-personnametype").data("identifier");
        $.post('http://esx_emsmdt/RemoveFakturaKarta', JSON.stringify({id: id, identifier: identifier}));
        $(this).parent().fadeOut(500);
    });

    $(document).on ("click", "#file-content-removenotatki", function() {
        const identifier = $("#file-personnametype").data("identifier");
        const note = $(this).parent().children('#file-content-note').html();
        $.post('http://esx_emsmdt/RemoveNotatkiKarta', JSON.stringify({identifier: identifier, note: note}));
        $(this).parent().fadeOut(500);
    });


    $(document).on ("click", "#file-more-info", function (event) {
        const name = $(this).parent().children(".file-who").children("#file-name").html();
        const identifier = $(this).parent().children(".file-who").children("#file-name").data("identifier");    
        const dateofbirth = $(this).parent().children(".file-date").html();
        $('#file-personnametype').html(name);
        $('#file-personnametype').data("identifier", identifier);
        $('#file-persondatetype').html(dateofbirth)
        $('.moreinfo-faktury').empty();
        $('.moreinfo-notatki').empty();
        $(".file-licenseholderinformation[data-type='nw']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='ambulance_firstaid']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='weapon']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='test_psycho']").children('.file-licenseowned').html('Nie');
        $.post('http://esx_emsmdt/PersonMoreInfo', JSON.stringify({identifier: identifier}), function(moreinfodata){
            for (let key in moreinfodata.faktury) {
                $('.moreinfo-faktury').append(
                    `<div class="file-content-holder" data-id="${moreinfodata.faktury[key].id}">
                        <div id="file-content-reason" style="width: 40%;">${moreinfodata.faktury[key].reason}</div>
                        <div id="file-content-fine" style="width: 15%;">$${moreinfodata.faktury[key].fee}</div>
                        <div id="file-content-police" style="width: 20%;">${moreinfodata.faktury[key].doctor}</div>
                        <div id="file-content-date" style="width: 15%;">${new Date(moreinfodata.faktury[key].date).toLocaleDateString("pl-PL")}</div>
                        <div id="file-content-removefaktura" style="width: 5%;"><i class="far fa-trash-alt"></i></div>
                    </div>`
                )
            }
            for (let key in moreinfodata.notatki) {
                $('.moreinfo-notatki').append(
                    `<div class="file-content-holder" style="margin-top: 0.5%;">
                        <div id="file-content-note" style="width: 50%;">${moreinfodata.notatki[key].notatka}</div>
                        <div id="file-content-date5" style="width: 20%;">${new Date(moreinfodata.notatki[key].date).toLocaleDateString("pl-PL")}</div>
                        <div id="file-content-police5" style="width: 20%;">${moreinfodata.notatki[key].doctor}</div>
                        <div id="file-content-removenotatki" style="width: 10%;"><i class="far fa-trash-alt"></i></div>
                    </div>`
                )
            }
            for (let key in moreinfodata.licenses) {
                const data = moreinfodata.licenses[key];
                $(".file-licenseholderinformation[data-type='" + data.type +"']").children('.file-licenseowned').html('Tak')                    
            }
        })
        $('.file-content').hide();
        $('.file-content2').show();
    });
    
    $('#file-button-notes').on('click', function(){
        const note = $('#file-button-notetext').val();
        const identifier = $("#file-personnametype").data("identifier");
        if (note != "") {
            $("#file-button-notetext").val("");
            $.post('http://esx_emsmdt/AddNotatkaKarta', JSON.stringify({identifier: identifier, note: note}), function(notedata){
                $('.moreinfo-notatki').append(
                    `<div class="file-content-holder" style="margin-top: 0.5%;">
                        <div id="file-content-note" style="width: 50%;">${notedata.notatka}</div>
                        <div id="file-content-date5" style="width: 20%;">${new Date(notedata.date*1000).toLocaleDateString("pl-PL")}</div>
                        <div id="file-content-police5" style="width: 20%;">${notedata.doctor}</div>
                        <div id="file-content-removenotatki" style="width: 10%;"><i class="far fa-trash-alt"></i></div>
                    </div>`
                )
            }); 
        }
    })

    $('.nav-select').on('click', function(){
        $('.nav-select').removeClass('nav-select-color');
        $(this).addClass('nav-select-color');
    })

    $('.tariff-button').on('click', function(){
        $('.tariff-button').removeClass('tariff-button-selected');
        $(this).addClass('tariff-button-selected');
    })

    $('.file-content-button').on('click', function(){
        $('.file-content-button').removeClass('file-content-selected');
        $(this).addClass('file-content-selected');
    })

    $('.nav-select').click(function () {

        switch ($(this).attr('id')) {

            case 'default':
                hide();
                $('.default-content').delay(110).fadeIn(100);
            break;
            
            case 'fine':
                hide();
                $('.fine-content').delay(110).fadeIn(100);
                $('.nearbyPlayers').empty();
                $.post('http://esx_emsmdt/NearbyPlayers', function(nearbyplayers){
                    for (let key in nearbyplayers) {
                        $(".nearbyPlayers").append(new Option(nearbyplayers[key].name));
                    }
                })
            break;

            case 'tariff':
                hidetariff();
                hide();
                $('.tariff-content').delay(110).fadeIn(100);
                $('.tariff-title').text('Podstawowe badania');
                $('#tariff-1-1').show();
                $('.tariff-button').removeClass('tariff-button-selected');
                $('.default-tariff').addClass('tariff-button-selected');
            break;

            case 'file':
                hide();
                $('.file-content').delay(110).fadeIn(100);
            break;

            case 'note':
                hide();
                $('.note-content').delay(110).fadeIn(100);
            break;

            case 'announcements':
                hide();
                $('.announcements-content').delay(110).fadeIn(100);
            break;

            case 'raports':
                hide();
                $('.raport-content').delay(110).fadeIn(100);
            break;

            // case 'dispatch':
            //     hide();
            //     $('.dispatch-content').delay(110).fadeIn(100);
            // break;
            
        }
    });

    $('.tariff-button').click(function () {

        switch ($(this).attr('id')) {

            case 'tariff-1':
                $('.tariff-title').text('Podstawowe badania');
                hidetariff();
                $('#tariff-1-1').show();
            break;

            case 'tariff-2':
                $('.tariff-title').text('Badania specjalistyczne');
                hidetariff();
                $('#tariff-2-2').show();
            break;

            case 'tariff-3':
                $('.tariff-title').text('Operacje/Zabiegi');
                hidetariff();
                $('#tariff-3-3').show();
            break;

            case 'tariff-4':
                $('.tariff-title').text('Hospitalizacja');
                hidetariff();
                $('#tariff-4-4').show();
            break;

            case 'tariff-5':
                $('.tariff-title').text('Kursy');
                hidetariff();
                $('#tariff-5-5').show();
            break;
        }
    });

    $('.file-content-button').click(function () {
        switch ($(this).attr('id')) {
            case 'file-content-1':
                hidefile();
                $('[id=file-content-1-1]').show();
                $('#file-notes-show').hide();
            break;

            case 'file-content-5':
                hidefile();
                $('[id=file-content-5-5]').show();
                $('#file-notes-show').show();
            break;
        }
    });

    $('#person-search').click(function(){
        const firstname = $('#firstname-kartapacjenta').val();
        const lastname = $('#lastname-kartapacjenta').val();

        $.post('http://esx_emsmdt/SearchPersonKartaPacjenta', JSON.stringify({firstname: firstname, lastname: lastname}), function(persondata){
            $('.file-founded-box').show();
            $('.file-holder-content').empty();
            for (let key in persondata) {
                let phone_number = persondata[key].phone_number
                let age = 2020 - parseInt(persondata[key].dateofbirth.substring(0, 4))
                if(phone_number == "") {
                    phone_number = "Brak"
                }
                $('.file-holder-content').append(`
                    <div class="file-holder-info" style="margin-top: 1%; margin-bottom: 0.5%; border-radius: 0px; height: 50px;">
                        <div class="file-who">
                            <div class="file-who-photo"></div>
                            <span id="file-name" data-identifier="${persondata[key].identifier}">${persondata[key].firstname} ${persondata[key].lastname}</span>
                        </div> 
                        <div class="file-date">${persondata[key].dateofbirth}</div>
                        <div class="file-age">${age}</div>
                        <div class="file-phone">${phone_number}</div>
                        <div class="file-look" id="file-more-info"><i class="fas fa-arrow-right"></i></div>
                    </div>
                `)
            }
        })

    });

});

//Hide
function hide() {
    $('.default-content, .fine-content, .tariff-content, .file-content, .file-content2, .note-content, .announcements-content, .raport-content, .dispatch-content').hide();
    UpdateNotepad()
}

//Tariff
function hidetariff() {
    $('#tariff-1-1, #tariff-2-2, #tariff-3-3, #tariff-4-4, #tariff-5-5').hide();
}

//File
function hidefile() {
    $('[id=file-content-1-1], [id=file-content-2-2], [id=file-content-3-3], [id=file-content-4-4], [id=file-content-5-5]').hide();
}

//Plus minus
$(document).ready(function(){
    var test = document.getElementsByClassName("no");
    var test2 = document.getElementsByClassName("yes");
    for (var i = 0; i < test.length; i++) {    
        test[i].onclick = function() {
            var lel = $(this).parents()[1];
            var qee = lel.querySelector('.file-licenseowned');
            var type = $(this).parent().parent().data('type')
            var identifier = $("#file-personnametype").data("identifier");
            qee.innerHTML = "Nie";
            console.log(type)
            $.post('http://esx_emsmdt/licencjaUsun', JSON.stringify({identifier: identifier, type: type}));
        }
    }
    for (var i = 0; i < test2.length; i++) {    
        test2[i].onclick = function() {
            var lel = $(this).parents()[1];
            var qee = lel.querySelector('.file-licenseowned');
            var type = $(this).parent().parent().data('type')
            var identifier = $("#file-personnametype").data("identifier");
            qee.innerHTML = "Tak";
            console.log(type)
            $.post('http://esx_emsmdt/licencjaDodaj', JSON.stringify({identifier: identifier, type: type}));
        }
    }
});


$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESCAPE
            CloseMdt()
        break;
    }
});

function CloseMdt() {
    hide();
    hidetariff();
    hidefile();
    $('.nav-select').removeClass('nav-select-color');
    $('#default').addClass('nav-select-color');
    $('.tablet-all').hide();
    $.post('http://esx_emsmdt/mdtclose');
}

function UpdateNotepad() {
    const note = $('#note-textbox').val();
    $.post('http://esx_emsmdt/UpdateNotepad', JSON.stringify({note: note}));
}
