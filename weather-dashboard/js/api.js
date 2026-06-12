/**
 * WEATHER DASHBOARD - API Manager
 * Gerencia requisições para a API OpenWeatherMap
 */

class WeatherAPI {
    constructor() {
        this.baseUrl = API_CONFIG.OPENWEATHER.baseUrl;
        this.apiKey = API_CONFIG.OPENWEATHER.apiKey;
        this.units = API_CONFIG.OPENWEATHER.defaultUnits;
        this.language = API_CONFIG.OPENWEATHER.defaultLanguage;
    }

    /**
     * Busca dados climáticos atuais
     */
    async getCurrentWeather(lat, lon) {
        try {
            const url = `${this.baseUrl}${API_CONFIG.OPENWEATHER.endpoints.current}?lat=${lat}&lon=${lon}&units=${this.units}&lang=${this.language}&appid=${this.apiKey}`;
            const response = await this.fetchWithTimeout(url);
            return response;
        } catch (error) {
            throw new Error(`Erro ao buscar clima atual: ${error.message}`);
        }
    }

    /**
     * Busca previsão de 5 dias
     */
    async getForecast(lat, lon) {
        try {
            const url = `${this.baseUrl}${API_CONFIG.OPENWEATHER.endpoints.forecast}?lat=${lat}&lon=${lon}&units=${this.units}&lang=${this.language}&appid=${this.apiKey}`;
            const response = await this.fetchWithTimeout(url);
            return response;
        } catch (error) {
            throw new Error(`Erro ao buscar previsão: ${error.message}`);
        }
    }

    /**
     * Busca coordenadas a partir do nome da cidade
     */
    async getCoordinates(cityName) {
        try {
            const url = `${this.baseUrl}${API_CONFIG.OPENWEATHER.endpoints.geocoding}?q=${encodeURIComponent(cityName)}&limit=5&appid=${this.apiKey}`;
            const response = await this.fetchWithTimeout(url);
            return response;
        } catch (error) {
            throw new Error(`Erro ao buscar coordenadas: ${error.message}`);
        }
    }

    /**
     * Busca clima por nome de cidade
     */
    async getWeatherByCity(cityName) {
        const coordinates = await this.getCoordinates(cityName);
        if (coordinates.length === 0) {
            throw new Error('Cidade não encontrada');
        }
        const { lat, lon } = coordinates[0];
        const weather = await this.getCurrentWeather(lat, lon);
        const forecast = await this.getForecast(lat, lon);
        return { weather, forecast, coordinates };
    }

    /**
     * Busca clima por coordenadas GPS
     */
    async getWeatherByCoordinates(lat, lon) {
        try {
            const weather = await this.getCurrentWeather(lat, lon);
            const forecast = await this.getForecast(lat, lon);
            return { weather, forecast };
        } catch (error) {
            throw new Error(`Erro ao buscar clima: ${error.message}`);
        }
    }

    /**
     * Requisição com timeout
     */
    async fetchWithTimeout(url) {
        const controller = new AbortController();
        const timeout = setTimeout(() => controller.abort(), API_CONFIG.timeout);

        try {
            const response = await fetch(url, { signal: controller.signal });
            clearTimeout(timeout);

            if (!response.ok) {
                if (response.status === 401) {
                    throw new Error('Chave da API inválida ou expirada');
                } else if (response.status === 404) {
                    throw new Error('Cidade não encontrada');
                } else if (response.status === 429) {
                    throw new Error('Limite de requisições excedido. Tente novamente em alguns minutos.');
                } else {
                    throw new Error(`Erro ${response.status}: ${response.statusText}`);
                }
            }

            return await response.json();
        } catch (error) {
            clearTimeout(timeout);
            if (error.name === 'AbortError') {
                throw new Error('Requisição expirou. Verifique sua conexão.');
            }
            throw error;
        }
    }
}

// Instância global
const weatherAPI = new WeatherAPI();
