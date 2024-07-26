BossMenu = {
    Lang = {
        ['sei_stato_uppato'] = 'Zostałeś awansowany na %s, w pracy %s przez %s',
        ['hai_uppato'] = 'Awansowałeś %s na %s, w pracy %s',
        ['sei_stato_degradato'] = 'Zostałeś zdegradowany na %s, w pracy %s przez %s',
        ['hai_degradato'] = 'Zdegradowałeś %s na %s, w pracy %s',
        ['sei_stato_licenziato'] = 'Zostałeś zwolniony z %s, w pracy %s',
        ['hai_licenziato'] = 'Zwolniłeś %s, w pracy %s',
        ['hai_depositato'] = 'Wpłaciłeś %s$ %s',
        ['hai_prelevato'] = 'Wypłaciłeś %s$ %s',
        ['no_player_vicini'] = 'Nie ma nikogo w pobliżu',
        ['hai_assunto'] = 'Zatrudniłeś %s',
        ['sei_stato_assunto'] = 'Zostałeś zatrudniony przez %s'
    },
    JobDisoccupato = 'unemployed',
    GradoDisoccupato = 0,
    Background_Image = '',
    DoubleJob = false, -- true se usi quello dell'extended, false se nn lo hai 
    Options = { -- mettere sempre off (job_secondario) se nn hai il double job tramite extended
        ['police'] = {
            gradi = {
                'boss',
            },
            job_secondario = false,
        },
        ['craftbar'] = {
            gradi = {
                'boss',
                'viceboss',
            },
            job_secondario = false,
        },
        ['nikki'] = {
            gradi = {
                'boss',
                'viceboss',
            },
            job_secondario = false,
        },
        ['cardealer'] = {
            gradi = {
                'boss',
            },
            job_secondario = true,
        },
        ['armeria'] = {
            gradi = {
                'boss',
                'viceboss',
            },
            job_secondario = false,
        },
    },
}