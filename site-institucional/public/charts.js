const ctx01 = document.getElementById('canvas_chart01');
const ctx02 = document.getElementById('canvas_chart02');
const ctx03 = document.getElementById('canvas_chart03');

new Chart(ctx01, {
    type: 'line',
    data: {
        labels: ['10/10', '11/10', '12/10', '13/10', '14/10', '15/10'],
        datasets: [{
            label: 'Garrafas',
            data: [1112, 1119, 1333, 1535, 2422, 1243],
            borderWidth: 1
        },
        {
            
            label: 'Frascos',
            data: [1342, 2189, 1873, 1335, 1782, 2243],
            borderWidth: 1
        },
        {
            label: 'Copos',
            data: [1282, 1002, 1133, 1200, 1058, 1143],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: false
            }
        }
    }
});

new Chart(ctx02, {
    type: 'pie',
    data: {
        labels: ['Produzido', 'Perda'],
        datasets: [{
            data: [12456, 2130],
            borderWidth: 1,
            backgroundColor: ['#32CD32', '#ff0000']
            }]
    }
});

new Chart(ctx03, {
    type: 'line',
    data: {
        labels: ['01/10', '02/10', '03/10', '04/10', '05/10', '06/10','07/10', '08/10', '09/10', '10/10', '11/10', '12/10','13/10'],
        datasets: [
            {
                label: 'Esteira A',
                data: [1,1,1,1,1,1,1,1,1,1,1,0,1],
                fill: false,
                stepped: true,
            },
            {
                label: 'Esteira B',
                data: [1,1,1,1,1,1,1,1,1,1,1,1,1],
                fill: false,
                stepped: true,
            },
            {
                label: 'Esteira C',
                data: [1,1,1,1,1,1,0,1,1,1,1,1,1],
                fill: false,
                stepped: true,
            },
            {
                label: 'Esteira D',
                data: [1,1,1,1,1,1,1,1,1,1,1,1,1],
                fill: false,
                stepped: true,
            },
            {
                label: 'Esteira E',
                data: [1,1,1,1,1,1,1,1,1,1,1,1,1],
                fill: false,
                stepped: true,
            },
            {
                label: 'Esteira F',
                data: [1,0,1,1,1,1,1,1,1,1,1,1,1],
                fill: false,
                stepped: true,
            },
        ]
    },
    options: {
        responsive: true,
        interaction: {
            intersect: false,
            axis: 'x'
        },
        plugins: {
            title: {
                display: false,
                text: (ctx) => 'Step ' + ctx.chart.data.datasets[0].stepped + ' Interpolation',
            }
        },
        maintainAspectRatio: false,
        
    }
});

ctx03.canvas.parentNode.style.width = '100%';



