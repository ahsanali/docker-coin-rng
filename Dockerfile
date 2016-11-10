FROM python
RUN pip install Flask
COPY rng /

CMD ["python", "rng/rng.py"]
EXPOSE 80
