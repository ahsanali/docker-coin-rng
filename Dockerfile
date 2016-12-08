FROM python
RUN pip install Flask awscli
COPY rng rng/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["sh /usr/local/bin/docker-entrypoint.sh"]

EXPOSE 80

CMD ["python", "rng/rng.py"]



