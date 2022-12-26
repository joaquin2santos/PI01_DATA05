from fastapi import  FastAPI
import pymysql


api = FastAPI()

@api.get("/")
async def bienvenidos():  
          mensaje_A = 'Bienvenidos a la api del proyecto Data Engineer 01'
          mensaje_B = 'puede usar las funciones get_max_duration, get_count_plataform/, get_listed_in,  get_actor '
          return  mensaje_A, mensaje_B 

conexion = pymysql.connect(
  host = 'localhost',
  user = 'root',
  password = '****',
  port = 3306,
  database = 'proyecto')
cursor = conexion.cursor()

## consigna 1
@api.get("/get_max_duration")
async def get_max_duration(anio:int, plataform:str, Movie_o_TVShow:str):         
      cursor.execute(f"""SELECT  title, duration, release_year
                    FROM peliculas 
                    WHERE  type_Movie =('{Movie_o_TVShow}') or type_TV=('{Movie_o_TVShow}') and plataforma =('{plataform}') and release_year= ('{anio}')
                    ORDER BY duration DESC
                    LIMIT 1;""")
      return cursor.fetchall()



## consigna 2
@api.get("/get_count_plataform/")
async def get_count_plataform(plataforma:str):
      cursor.execute(f"""SELECT  plataforma, COUNT(type_Movie) as movie, count(type_TV) as tvshow
      FROM peliculas
      where  plataforma = '{plataforma}';""")
      return cursor.fetchall()[0]



## consigna 3

@api.get("/get_listed_in/")
async def get_listed_in(genero: str, plataforma :str):
            cursor.execute(f""" select plataforma, count(*)
                            from(select * from peliculas
              where listed_in like concat('%','{genero}','%') and plataforma = "{plataforma}") as p;
            """)
            return cursor.fetchall()[0]

##consigna 4
@api.get("/get_actor/")
async def get_actor(plataforma, anio):
      cursor.execute(f"""SELECT cast, count(cast)as cantidad, release_year
                         FROM (SELECT * FROM peliculas 
                         WHERE  release_year ={anio} and plataforma='{plataforma}') p;""")
      return cursor.fetchall()