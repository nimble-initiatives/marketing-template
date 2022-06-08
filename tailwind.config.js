module.exports = {
  content: ['./Views/**/*.{cshtml,js}'],
  theme: {
    extend: {

    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
  ],
};
