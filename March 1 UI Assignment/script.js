document.addEventListener('DOMContentLoaded', function() {
    const slides = document.querySelectorAll('.slide');
    const dots = document.querySelectorAll('.slider-dot');
    let currentSlide = 0;

    function showSlide(index) {
        slides.forEach(slide => {
            slide.classList.remove('active');
        });
        
        dots.forEach(dot => {
            dot.classList.remove('active');
        });
        
        slides[index].classList.add('active');
        dots[index].classList.add('active');
    }

    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            currentSlide = index;
            showSlide(currentSlide);
        });
    });

    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }

    if (slides.length > 1) {
        setInterval(nextSlide, 5000);
    }

    const tabBtns = document.querySelectorAll('.tab-btn');
    
    if (tabBtns.length > 0) {
        tabBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                tabBtns.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                
                const category = btn.getAttribute('data-category');
                filterNewsByCategory(category);
            });
        });
    }

    const searchBtn = document.getElementById('search-btn');
    const searchInput = document.getElementById('search');
    
    if (searchBtn && searchInput) {
        searchBtn.addEventListener('click', () => {
            performSearch();
        });
        
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
    }
    
    function performSearch() {
        const searchTerm = searchInput.value.toLowerCase().trim();
        
        if (searchTerm) {
            const newsCards = document.querySelectorAll('.news-card');
            const featuredSlides = document.querySelectorAll('.slide');
            let resultsFound = 0;

            const existingResults = document.querySelector('.search-results');
            if (existingResults) {
                existingResults.remove();
            }

            const searchResults = document.createElement('div');
            searchResults.className = 'search-results';
            
            const resultsHeader = document.createElement('h2');
            resultsHeader.className = 'section-title';
            resultsHeader.textContent = `Search Results for "${searchTerm}"`;
            searchResults.appendChild(resultsHeader);
            
            const resultsGrid = document.createElement('div');
            resultsGrid.className = 'news-grid';

            newsCards.forEach(card => {
                const title = card.querySelector('h3').textContent.toLowerCase();
                const description = card.querySelector('p').textContent.toLowerCase();
                const category = card.querySelector('.category') ? 
                    card.querySelector('.category').textContent.toLowerCase() : '';
                
                if (title.includes(searchTerm) || description.includes(searchTerm) || category.includes(searchTerm)) {
                    resultsGrid.appendChild(card.cloneNode(true));
                    resultsFound++;
                }
            });

            featuredSlides.forEach(slide => {
                const title = slide.querySelector('h2') ? 
                    slide.querySelector('h2').textContent.toLowerCase() : '';
                const description = slide.querySelector('p') ? 
                    slide.querySelector('p').textContent.toLowerCase() : '';
                const category = slide.querySelector('.category') ? 
                    slide.querySelector('.category').textContent.toLowerCase() : '';
                
                if (title.includes(searchTerm) || description.includes(searchTerm) || category.includes(searchTerm)) {
                    const card = document.createElement('div');
                    card.className = 'news-card';
                    
                    const img = slide.querySelector('img').cloneNode(false);
                    card.appendChild(img);
                    
                    const content = document.createElement('div');
                    content.className = 'news-content';
                    
                    if (category) {
                        const categorySpan = document.createElement('span');
                        categorySpan.className = 'category';
                        categorySpan.textContent = slide.querySelector('.category').textContent;
                        content.appendChild(categorySpan);
                    }
                    
                    const heading = document.createElement('h3');
                    heading.textContent = title ? slide.querySelector('h2').textContent : 'Featured Article';
                    content.appendChild(heading);
                    
                    if (description) {
                        const para = document.createElement('p');
                        para.textContent = slide.querySelector('p').textContent;
                        content.appendChild(para);
                    }
                    
                    const link = document.createElement('a');
                    link.href = 'article.html';
                    link.textContent = 'Read More';
                    content.appendChild(link);
                    
                    card.appendChild(content);
                    resultsGrid.appendChild(card);
                    resultsFound++;
                }
            });
            
            searchResults.appendChild(resultsGrid);

            if (resultsFound === 0) {
                const noResults = document.createElement('p');
                noResults.className = 'no-results';
                noResults.textContent = 'No results found. Please try a different search term.';
                searchResults.appendChild(noResults);
            }

            const latestNewsSection = document.querySelector('.latest-news');
            if (latestNewsSection) {
                latestNewsSection.parentNode.insertBefore(searchResults, latestNewsSection);
                searchResults.scrollIntoView({ behavior: 'smooth' });
                const contentSections = document.querySelectorAll('.latest-news, .categories-tabs, .featured-articles');
                contentSections.forEach(section => {
                    section.style.display = 'none';
                });
            }

            const clearBtn = document.createElement('button');
            clearBtn.className = 'clear-search-btn';
            clearBtn.textContent = 'Clear Search';
            clearBtn.addEventListener('click', () => {
                searchResults.remove();

                const contentSections = document.querySelectorAll('.latest-news, .categories-tabs, .featured-articles');
                contentSections.forEach(section => {
                    section.style.display = 'block';
                });

                searchInput.value = '';
            });
            
            searchResults.insertBefore(clearBtn, resultsGrid);
        }
    }
    
    function filterNewsByCategory(category) {
        const newsCards = document.querySelectorAll('.news-card');
        
        newsCards.forEach(card => {
            const cardCategory = card.querySelector('.category') ? 
                card.querySelector('.category').textContent.toLowerCase() : '';
                
            if (category === 'all' || cardCategory.toLowerCase() === category.toLowerCase()) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    const videoContainer = document.querySelector('.video-container');
    
    if (videoContainer) {
        videoContainer.addEventListener('click', () => {
            alert('Video would play here in a real implementation');
        });
    }

    const commentForm = document.getElementById('comment-form');
    
    if (commentForm) {
        commentForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const nameInput = document.getElementById('name');
            const commentInput = document.getElementById('comment');
            
            if (nameInput.value.trim() && commentInput.value.trim()) {
                alert('Comment submitted successfully!');
                nameInput.value = '';
                commentInput.value = '';
            }
        });
    }

    const shareBtns = document.querySelectorAll('.share-btn');
    
    if (shareBtns.length > 0) {
        shareBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                const platform = btn.classList[1];
                alert(`Sharing on ${platform}`);
            });
        });
    }
});