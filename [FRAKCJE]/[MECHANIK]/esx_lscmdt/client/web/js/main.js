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
                for (let key in data.Mechanic) {
                    let status = 'Nie';
                    if(data.Mechanic[key].duty_status != null) {
                        if(data.Mechanic[key].duty_status == 1) {
                            status = 'Nie';
                        } else if(data.Mechanic[key].duty_status == 2) {
                            status = 'Tak';
                        }
                    }
                    $('#onduty-info').append(
                        `<div class='default-duty-info' style='margin-top: 8px;'>
                            <div class='duty-who'>${data.Mechanic[key].firstname + ' ' + data.Mechanic[key].lastname}</div>
                            <div class="duty-number">${data.Mechanic[key].phone_number}</div>
                            <div class="duty-online">
                                <div class="duty-yes"><span style="color: ${data.Mechanic[key].color};">${status}</span></div>
                            </div>
                        </div>`
                    )
                }
                for (let key in data.OstatnieFaktury) {
                    $('#ostatniefaktury-info').append(
                        `<div class="default-duty-info" style="margin-top: 8px; text-align: center;">
                            <div class="default-fineid">#${data.OstatnieFaktury[key].id}</div>
                            <div class="default-person">${data.OstatnieFaktury[key].client}</div>
                            <div class="default-date">${new Date(data.OstatnieFaktury[key].date).toLocaleDateString("pl-PL")}</div>
                            <div class="default-officer">${data.OstatnieFaktury[key].mechanic}</div>
                            <div class="default-fine">${data.OstatnieFaktury[key].fee}$</div>
                        </div>`
                    )
                }
                for (let key in data.Ogloszenia) {
                    $('.announcements-content-undermenu').append(
                        `<div class="announcements-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                            <div id="announcements-content-reason" style="width: 43%;">${data.Ogloszenia[key].ogloszenie}</div>
                            <div id="announcements-content-fine" style="width: 20%;">${data.Ogloszenia[key].mechanic}</div>
                            <div id="announcements-content-date" style="width: 20%;">${new Date(data.Ogloszenia[key].date).toLocaleDateString("pl-PL")}</div>
                            <div id="announcements-content-remove" style="width: 5%; display: ${show};"><i class="far fa-trash-alt"></i></div>
                        </div>`
                    )
                }
                for (let key in data.Raporty) {
                    $('.raport-content-undermenu').append(
                        `<div class="raport-content-holder" style="margin-top: 1%; margin-bottom: 0.5%;">
                            <div id="raport-content-reason" style="width: 43%;">${data.Raporty[key].raport}</div>
                            <div id="raport-content-fine" style="width: 20%;">${data.Raporty[key].mechanic}</div>
                            <div id="raport-content-date" style="width: 20%;">${new Date(data.Raporty[key].date).toLocaleDateString("pl-PL")}</div>
                            <div id="raport-content-remove" style="width: 5%; display: ${show};"><i class="far fa-trash-alt"></i></div>
                        </div>`
                    )
                }
            break;
        }
    })

    $('#wystaw-faktura-button').on('click', function(){
        const id = $('#fakturaPlayer').val();
        const fee = $('#fee-faktura').val();
        const text = $('#text-faktura').val();
        if(fee != "" && text != "") {
            $('#fee-faktura').val("");
            $('#text-faktura').val("");
            $.post('http://esx_lscmdt/WystawFakture', JSON.stringify({id: id.split('[').pop().split(']')[0], fee: fee, text: text}));
        }
    })


    $('#send_raport').on('click', function(){
        const text = $('#raport_textbox').val();
        $('#raport_textbox').val("");
        $.post('http://esx_lscmdt/SendRaport', JSON.stringify({text: text}), function(raportdata){
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

    $(document).on ("click", "#raport-content-remove", function () {
        const owner = $(this).parent().children("#raport-content-fine").html();
        const text = $(this).parent().children("#raport-content-reason").html();
        $.post('http://esx_lscmdt/RemoveRaport', JSON.stringify({fp: owner, raport: text}));
        $(this).parent().fadeOut(500);
    });

    $('#send_announce').on('click', function(){
        const text = $('#announce_textbox').val();
        $('#announce_textbox').val("");
        $.post('http://esx_lscmdt/SendAnnounce', JSON.stringify({text: text}), function(announcedata){
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

    $(document).on ("click", "#announcements-content-remove", function () {
        const owner = $(this).parent().children("#announcements-content-fine").html();
        const text = $(this).parent().children("#announcements-content-reason").html();
        $.post('http://esx_lscmdt/RemoveAnnounce', JSON.stringify({fp: owner, ogloszenie: text}));
        $(this).parent().fadeOut(500);
    });


    $('#person-search').click(function(){
        const firstname = $('#firstname-kartapojazdu').val();
        const lastname = $('#lastname-kartapojazdu').val();
        console.log(firstname, lastname)
        $.post('http://esx_lscmdt/SearchPersonKartaPojazdu', JSON.stringify({firstname: firstname, lastname: lastname}), function(persondata){
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

    $(document).on ("click", "#file-more-info", function (event) {
        const name = $(this).parent().children(".file-who").children("#file-name").html();
        const identifier = $(this).parent().children(".file-who").children("#file-name").data("identifier");    
        const dateofbirth = $(this).parent().children(".file-date").html();
        $('#file-personnametype').html(name);
        $('#file-personnametype').data("identifier", identifier);
        $('#file-persondatetype').html(dateofbirth)
        $('.moreinfo-faktury').empty();
        $('.moreinfo-pojazdy').empty();
        $('.moreinfo-notatki').empty();
        $(".file-licenseholderinformation[data-type='drive_bike']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='drive']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='drive_truck']").children('.file-licenseowned').html('Nie');
        $(".file-licenseholderinformation[data-type='oc']").children('.file-licenseowned').html('Nie'); 
        $.post('http://esx_lscmdt/PersonMoreInfo', JSON.stringify({identifier: identifier}), function(moreinfodata){
            for (let key in moreinfodata.faktury) {
                $('.moreinfo-faktury').append(
                    `<div class="file-content-holder" data-id="${moreinfodata.faktury[key].id}">
                        <div id="file-content-reason" style="width: 40%;">${moreinfodata.faktury[key].reason}</div>
                        <div id="file-content-fine" style="width: 15%;">$${moreinfodata.faktury[key].fee}</div>
                        <div id="file-content-police" style="width: 20%;">${moreinfodata.faktury[key].mechanic}</div>
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
                        <div id="file-content-police5" style="width: 20%;">${moreinfodata.notatki[key].mechanic}</div>
                        <div id="file-content-removenotatki" style="width: 10%;"><i class="far fa-trash-alt"></i></div>
                    </div>`
                )
            }
            for (let key in moreinfodata.pojadzy) {
                $('.moreinfo-pojazdy').append(
                    `<div class="file-content-holder" style="margin-top: 0.5%;">
                        <div id="file-content-carname" style="width: 50%;">${moreinfodata.pojadzy[key].model}</div>
                        <div id="file-content-carnumber" style="width: 50%;">${moreinfodata.pojadzy[key].plate}</div>
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
            $.post('http://esx_lscmdt/AddNotatkaKartaPojazdu', JSON.stringify({identifier: identifier, note: note}), function(notedata){
                $('.moreinfo-notatki').append(
                    `<div class="file-content-holder" style="margin-top: 0.5%;">
                        <div id="file-content-note" style="width: 50%;">${notedata.notatka}</div>
                        <div id="file-content-date5" style="width: 20%;">${new Date(notedata.date*1000).toLocaleDateString("pl-PL")}</div>
                        <div id="file-content-police5" style="width: 20%;">${notedata.mechanic}</div>
                        <div id="file-content-removenotatki" style="width: 10%;"><i class="far fa-trash-alt"></i></div>
                    </div>`
                )
            }); 
        }
    })

    $(document).on ("click", "#file-content-removenotatki", function() {
        const identifier = $("#file-personnametype").data("identifier");
        const note = $(this).parent().children('#file-content-note').html();
        $.post('http://esx_lscmdt/RemoveNotatkiKartaPojazdu', JSON.stringify({identifier: identifier, note: note}));
        $(this).parent().fadeOut(500);
    });

    $(document).on ("click", "#file-content-removefaktura", function() {
        const id = $(this).parent().data("id");
        const identifier = $("#file-personnametype").data("identifier");
        $.post('http://esx_emsmdt/RemoveFakturaKartaPojazdu', JSON.stringify({id: id, identifier: identifier}));
        $(this).parent().fadeOut(500);
    });

    $('.nav-select').on('click', function(){
        $('.nav-select').removeClass('nav-select-color');
        $(this).addClass('nav-select-color');
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
                $.post('http://esx_lscmdt/NearbyPlayers', function(nearbyplayers){
                    for (let key in nearbyplayers) {
                        $(".nearbyPlayers").append(new Option(nearbyplayers[key].name));
                    }
                })
            break;

            case 'jail':
                hide();
                $('.jail-content').delay(110).fadeIn(100);
                $('.nearbyPlayers').empty();
                $.post('http://esx_lscmdt/NearbyPlayers', function(nearbyplayers){
                    $(".nearbyPlayers").append(new Option(nearbyplayers.name));
                })
            break;

            case 'file':
                hide();
                $('.file-content').delay(110).fadeIn(100);
            break;

            case 'check-car':
                hide();
                $('.car-content').delay(110).fadeIn(100);
            break;

            case 'check-serialnumber':
                hide();
                $('.serial-content').delay(110).fadeIn(100);
            break;

            case 'check-sim':
                hide();
                $('.sim-content').delay(110).fadeIn(100);
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

            case 'dispatch':
                hide();
                $('.dispatch-content').delay(110).fadeIn(100);
            break;
            
        }
    });

    $('.file-content-button').click(function () {
        switch ($(this).attr('id')) {
            case 'file-content-1':
                hidefile();
                $('[id=file-content-1-1]').show();
                $('#file-search-show').hide();
                $('#file-notes-show').hide();
            break;

            case 'file-content-2':
                hidefile();
                $('[id=file-content-2-2]').show();
                $('#file-search-show').show();
                $('#file-notes-show').hide();
            break;

            case 'file-content-3':
                hidefile();
                $('[id=file-content-3-3]').show();
                $('#file-search-show').hide();
                $('#file-notes-show').hide();
            break;

            case 'file-content-4':
                hidefile();
                $('[id=file-content-4-4]').show();
                $('#file-search-show').hide();
                $('#file-notes-show').hide();
            break;

            case 'file-content-5':
                hidefile();
                $('[id=file-content-5-5]').show();
                $('#file-search-show').hide();
                $('#file-notes-show').show();
            break;
        }
    });
});

//Hide
function hide() {
    $('.default-content, .fine-content, .jail-content, .file-content, .file-content2, .car-content, .serial-content, .sim-content, .note-content, .announcements-content, .raport-content, .dispatch-content').hide();
    UpdateNotepad()
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
            $.post('http://esx_lscmdt/licencjaUsun', JSON.stringify({identifier: identifier, type: type}));
        }
    }
    for (var i = 0; i < test2.length; i++) {    
        test2[i].onclick = function() {
            var lel = $(this).parents()[1];
            var qee = lel.querySelector('.file-licenseowned');
            var type = $(this).parent().parent().data('type')
            var identifier = $("#file-personnametype").data("identifier");
            qee.innerHTML = "Tak";
            $.post('http://esx_lscmdt/licencjaDodaj', JSON.stringify({identifier: identifier, type: type}));
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
    hidefile();
    $('.nav-select').removeClass('nav-select-color');
    $('#default').addClass('nav-select-color');
    $('.tablet-all').hide();
    $.post('http://esx_lscmdt/mdtclose');
}

function UpdateNotepad() {
    const note = $('#note-textbox').val();
    console.log(note)
    $.post('http://esx_lscmdt/UpdateNotepad', JSON.stringify({note: note}));
}
