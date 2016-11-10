FROM python
RUN pip install Flask
COPY rng rng/

CMD ["python", "rng/rng.py"]
EXPOSE 80
