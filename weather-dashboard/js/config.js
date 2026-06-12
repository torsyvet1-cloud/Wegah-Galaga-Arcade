/**
 * WEATHER DASHBOARD - API Configuration
 * Configuração das credenciais e endpoints da API
 */

const API_CONFIG = {
    // OpenWeatherMap API
    OPENWEATHER: {
        baseUrl: 'https://api.openweathermap.org',
        // NOTA: Obtenha sua chave em: https://openweathermap.org/api
        // Use uma variável de ambiente ou insira sua chave aqui
        apiKey: process.env.OPENWEATHER_API_KEY || 'YOUR_API_KEY_HERE',
        endpoints: {
            current: '/data/2.5/weather',
            forecast: '/data/2.5/forecast',
            geocoding: '/geo/1.0/direct'
        }
    },

    // Configurações gerais
    defaultUnits: 'metric', // metric (Celsius), imperial (Fahrenheit)
    defaultLanguage: 'pt_BR',
    timeout: 10000 // 10 segundos
};

// Validar se a chave da API está configurada
if (!API_CONFIG.OPENWEATHER.apiKey || API_CONFIG.OPENWEATHER.apiKey === 'YOUR_API_KEY_HERE') {
    console.warn('⚠️  Aviso: Chave da API OpenWeatherMap não configurada!');
    console.warn('Acesse: https://openweathermap.org/api para obter sua chave gratuita');
}
