/**
 * WEATHER DASHBOARD - Main Application
 * Lógica principal da aplicação
 */

class WeatherApp {
    constructor() {
        this.init();
    }

    /**
     * Inicializa a aplicação
     */
    init() {
        this.setupEventListeners();
        this.checkApiKey();
        weatherUI.showEmpty();
    }

    /**
     * Verifica se a chave da API está configurada
     */
    checkApiKey() {
        if (!weatherAPI.apiKey || weatherAPI.apiKey === 'YOUR_API_KEY_HERE') {
            weatherUI.showToast(
                '⚠️  Configure sua chave da API em js/config.js',
                'warning'
            );
        }
    }

    /**
     * Configura listeners de eventos
     */
    setupEventListeners() {
        // Busca de cidade
        const searchBtn = document.getElementById('searchBtn');
        const cityInput = document.getElementById('cityInput');
        const locationBtn = document.getElementById('locationBtn');

        searchBtn.addEventListener('click', () => this.searchCity());
        cityInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') this.searchCity();
        });

        // Autocompletar
        cityInput.addEventListener('input', (e) => this.handleInput(e));
        document.addEventListener('click', (e) => {
            if (!e.target.closest('.search-wrapper')) {
                weatherUI.hideSuggestions();
            }
        });

        // Localização GPS
        locationBtn.addEventListener('click', () => this.useGeolocation());
    }

    /**
     * Busca por cidade
     */
    async searchCity() {
        const cityInput = document.getElementById('cityInput');
        const cityName = cityInput.value.trim();

        if (!cityName) {
            weatherUI.showToast('Por favor, digite um nome de cidade', 'warning');
            return;
        }

        if (cityName.length < 2) {
            weatherUI.showToast('Digite pelo menos 2 caracteres', 'warning');
            return;
        }

        await this.fetchWeather(cityName);
    }

    /**
     * Busca sugestões de cidades
     */
    async handleInput(e) {
        const cityName = e.target.value.trim();

        if (cityName.length < 2) {
            weatherUI.hideSuggestions();
            return;
        }

        try {
            const suggestions = await weatherAPI.getCoordinates(cityName);
            const cities = suggestions.map(city => ({
                name: city.name,
                state: city.state,
                country: city.country,
                lat: city.lat,
                lon: city.lon
            }));
            weatherUI.showSuggestions(cities);

            // Adiciona listeners aos itens de sugestão
            document.querySelectorAll('.suggestion-item').forEach(item => {
                item.addEventListener('click', () => {
                    const lat = item.dataset.lat;
                    const lon = item.dataset.lon;
                    this.fetchWeatherByCoordinates(lat, lon);
                });
            });
        } catch (error) {
            // Silenciosamente ignora erros de sugestão
            weatherUI.hideSuggestions();
        }
    }

    /**
     * Busca clima por nome de cidade
     */
    async fetchWeather(cityName) {
        weatherUI.showLoading();

        try {
            const data = await weatherAPI.getWeatherByCity(cityName);
            this.displayWeather(data.weather, data.forecast);
            document.getElementById('cityInput').value = '';
            weatherUI.hideSuggestions();
            weatherUI.hideEmpty();
        } catch (error) {
            weatherUI.hideLoading();
            weatherUI.showError(error.message);
        }
    }

    /**
     * Busca clima por coordenadas
     */
    async fetchWeatherByCoordinates(lat, lon) {
        weatherUI.showLoading();

        try {
            const data = await weatherAPI.getWeatherByCoordinates(lat, lon);
            this.displayWeather(data.weather, data.forecast);
            document.getElementById('cityInput').value = '';
            weatherUI.hideSuggestions();
            weatherUI.hideEmpty();
        } catch (error) {
            weatherUI.hideLoading();
            weatherUI.showError(error.message);
        }
    }

    /**
     * Usa geolocalização do navegador
     */
    useGeolocation() {
        if (!navigator.geolocation) {
            weatherUI.showToast(
                'Geolocalização não está disponível',
                'error'
            );
            return;
        }

        weatherUI.showLoading();
        navigator.geolocation.getCurrentPosition(
            (position) => {
                const { latitude, longitude } = position.coords;
                this.fetchWeatherByCoordinates(latitude, longitude);
            },
            (error) => {
                weatherUI.hideLoading();
                let message = 'Erro ao obter localização';
                if (error.code === error.PERMISSION_DENIED) {
                    message = 'Permissão de localização negada';
                } else if (error.code === error.POSITION_UNAVAILABLE) {
                    message = 'Localização não disponível';
                }
                weatherUI.showToast(message, 'error');
            }
        );
    }

    /**
     * Exibe dados climáticos
     */
    displayWeather(weatherData, forecastData) {
        weatherUI.hideLoading();
        weatherUI.renderCurrentWeather(weatherData);
        weatherUI.renderHourlyForecast(forecastData);
        weatherUI.renderDailyForecast(forecastData);
        weatherUI.updateLastUpdate();
    }
}

// Inicializa a aplicação quando o DOM estiver pronto
document.addEventListener('DOMContentLoaded', () => {
    const app = new WeatherApp();
});
