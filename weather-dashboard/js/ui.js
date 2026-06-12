/**
 * WEATHER DASHBOARD - UI Manager
 * Gerencia a interface do usuário
 */

class WeatherUI {
    constructor() {
        this.currentWeatherData = null;
        this.forecastData = null;
    }

    /**
     * Mostra carregamento
     */
    showLoading() {
        document.getElementById('loading').classList.remove('hidden');
        document.getElementById('error').classList.add('hidden');
        document.getElementById('currentWeatherSection').classList.add('hidden');
    }

    /**
     * Esconde carregamento
     */
    hideLoading() {
        document.getElementById('loading').classList.add('hidden');
    }

    /**
     * Mostra erro
     */
    showError(message) {
        const errorDiv = document.getElementById('error');
        errorDiv.innerHTML = `<i class="fas fa-exclamation-circle"></i> ${message}`;
        errorDiv.classList.remove('hidden');
        document.getElementById('currentWeatherSection').classList.add('hidden');
    }

    /**
     * Mostra sugestões de cidades
     */
    showSuggestions(cities) {
        const suggestionsDiv = document.getElementById('suggestions');
        
        if (cities.length === 0) {
            suggestionsDiv.classList.add('hidden');
            return;
        }

        suggestionsDiv.innerHTML = cities
            .map(city => `
                <div class="suggestion-item" data-lat="${city.lat}" data-lon="${city.lon}">
                    <strong>${city.name}</strong>
                    ${city.state ? `, ${city.state}` : ''}
                    <span style="color: #999;">${city.country}</span>
                </div>
            `)
            .join('');
        
        suggestionsDiv.classList.remove('hidden');
    }

    /**
     * Esconde sugestões
     */
    hideSuggestions() {
        document.getElementById('suggestions').classList.add('hidden');
    }

    /**
     * Renderiza clima atual
     */
    renderCurrentWeather(data) {
        this.currentWeatherData = data;
        const weather = data.weather[0];
        const main = data.main;
        const wind = data.wind;
        const sys = data.sys;

        // Conversões
        const tempC = Math.round(main.temp);
        const tempF = Math.round((main.temp * 9/5) + 32);
        const feelsLike = Math.round(main.feels_like);
        const windKmh = (wind.speed * 3.6).toFixed(1);
        const visibilityKm = (data.visibility / 1000).toFixed(1);
        const dewPoint = Math.round(main.temp - (100 - main.humidity) / 5);
        const sunrise = new Date(sys.sunrise * 1000);
        const sunset = new Date(sys.sunset * 1000);

        // Atualiza DOM
        document.getElementById('cityName').textContent = `${data.name}, ${data.sys.country}`;
        document.getElementById('currentDate').textContent = new Date().toLocaleDateString('pt-BR', {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });

        document.getElementById('temperature').textContent = `${tempC}°`;
        document.getElementById('weatherDescription').textContent = this.capitalizeWords(weather.description);
        document.getElementById('weatherIcon').src = this.getWeatherIcon(weather.icon);
        document.getElementById('humidity').textContent = `${main.humidity}%`;
        document.getElementById('windSpeed').textContent = `${windKmh} km/h`;
        document.getElementById('pressure').textContent = `${main.pressure} hPa`;
        document.getElementById('visibility').textContent = `${visibilityKm} km`;

        document.getElementById('sunrise').textContent = sunrise.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
        document.getElementById('sunset').textContent = sunset.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
        document.getElementById('dewPoint').textContent = `${dewPoint}°C`;
        document.getElementById('rainChance').textContent = `${data.clouds || 0}%`;

        document.getElementById('currentWeatherSection').classList.remove('hidden');
        document.getElementById('additionalSection').classList.remove('hidden');
    }

    /**
     * Renderiza previsão horária
     */
    renderHourlyForecast(data) {
        const hourlyContainer = document.getElementById('hourlyForecast');
        const now = new Date();
        const nextHours = data.list.slice(0, 8); // Próximas 24 horas

        hourlyContainer.innerHTML = nextHours
            .map(item => {
                const date = new Date(item.dt * 1000);
                const temp = Math.round(item.main.temp);
                const icon = item.weather[0].icon;

                return `
                    <div class="hourly-item">
                        <div class="hourly-time">${date.toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' })}</div>
                        <img src="${this.getWeatherIcon(icon)}" alt="" class="hourly-icon">
                        <div class="hourly-temp">${temp}°</div>
                    </div>
                `;
            })
            .join('');

        document.getElementById('hourlySection').classList.remove('hidden');
    }

    /**
     * Renderiza previsão diária
     */
    renderDailyForecast(data) {
        const dailyContainer = document.getElementById('dailyForecast');
        const dailyData = {};

        // Agrupa dados por dia
        data.list.forEach(item => {
            const date = new Date(item.dt * 1000);
            const dateKey = date.toLocaleDateString('pt-BR');

            if (!dailyData[dateKey]) {
                dailyData[dateKey] = {
                    date: date,
                    temps: [],
                    weather: item.weather[0],
                    icon: item.weather[0].icon,
                    humidity: [],
                    windSpeed: []
                };
            }

            dailyData[dateKey].temps.push(item.main.temp);
            dailyData[dateKey].humidity.push(item.main.humidity);
            dailyData[dateKey].windSpeed.push(item.wind.speed * 3.6);
        });

        dailyContainer.innerHTML = Object.values(dailyData)
            .slice(0, 7) // Próximos 7 dias
            .map(day => {
                const minTemp = Math.round(Math.min(...day.temps));
                const maxTemp = Math.round(Math.max(...day.temps));
                const avgHumidity = Math.round(day.humidity.reduce((a, b) => a + b) / day.humidity.length);
                const avgWind = (day.windSpeed.reduce((a, b) => a + b) / day.windSpeed.length).toFixed(1);

                return `
                    <div class="daily-item">
                        <div class="daily-header">
                            <span class="daily-date">${day.date.toLocaleDateString('pt-BR', { weekday: 'short', month: 'short', day: 'numeric' })}</span>
                            <img src="${this.getWeatherIcon(day.icon)}" alt="" class="daily-icon">
                        </div>
                        <div class="daily-info">
                            <div class="daily-info-item">
                                <span class="daily-label">Temperatura</span>
                                <span class="daily-value">${minTemp}° - ${maxTemp}°</span>
                            </div>
                            <div class="daily-info-item">
                                <span class="daily-label">Descrição</span>
                                <span class="daily-value">${this.capitalizeWords(day.weather.description)}</span>
                            </div>
                            <div class="daily-info-item">
                                <span class="daily-label">Umidade</span>
                                <span class="daily-value">${avgHumidity}%</span>
                            </div>
                            <div class="daily-info-item">
                                <span class="daily-label">Vento</span>
                                <span class="daily-value">${avgWind} km/h</span>
                            </div>
                        </div>
                    </div>
                `;
            })
            .join('');

        document.getElementById('dailySection').classList.remove('hidden');
    }

    /**
     * Mostra estado vazio
     */
    showEmpty() {
        document.getElementById('emptyState').classList.remove('hidden');
        document.getElementById('currentWeatherSection').classList.add('hidden');
        document.getElementById('hourlySection').classList.add('hidden');
        document.getElementById('dailySection').classList.add('hidden');
        document.getElementById('additionalSection').classList.add('hidden');
    }

    /**
     * Esconde estado vazio
     */
    hideEmpty() {
        document.getElementById('emptyState').classList.add('hidden');
    }

    /**
     * Mostra notificação (toast)
     */
    showToast(message, type = 'success') {
        const toast = document.getElementById('toast');
        toast.textContent = message;
        toast.className = `toast ${type}`;
        toast.classList.remove('hidden');

        setTimeout(() => {
            toast.classList.add('hidden');
        }, 3000);
    }

    /**
     * Obtém URL do ícone de clima
     */
    getWeatherIcon(iconCode) {
        return `https://openweathermap.org/img/wn/${iconCode}@4x.png`;
    }

    /**
     * Capitaliza palavras
     */
    capitalizeWords(str) {
        return str.split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
    }

    /**
     * Atualiza data da última atualização
     */
    updateLastUpdate() {
        document.getElementById('lastUpdate').textContent = new Date().toLocaleTimeString('pt-BR');
    }
}

// Instância global
const weatherUI = new WeatherUI();
