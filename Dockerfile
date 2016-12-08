FROM python
RUN pip install Flask awscli
COPY rng rng/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 80

CMD ["python", "rng/rng.py"]



