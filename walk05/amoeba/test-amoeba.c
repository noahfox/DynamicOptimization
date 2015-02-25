/**********************************************************************/

#include <stdio.h>
#include <gsl/gsl_multimin.h>

/**********************************************************************/
/* Test optimization criterion is a paraboloid centered on (p[0],p[1]) */
     
double my_f( const gsl_vector *v, void *params )
{
  double x, y;
  double *p = (double *)params;
       
  x = gsl_vector_get(v, 0);
  y = gsl_vector_get(v, 1);
      
  return (x - p[0]) * (x - p[0]) +
    (y - p[1]) * (y - p[1]); 
}

/**********************************************************************/
/* Test function */

main()
{
  size_t iter = 0;
  int status;
  double size;
  gsl_multimin_function my_func;
  const gsl_multimin_fminimizer_type *T = gsl_multimin_fminimizer_nmsimplex;
  gsl_multimin_fminimizer *s = NULL;
  gsl_vector *ss, *x;
  /* Paraboloid center at (1,2) */
  double p[2] = { 1.0, 2.0 };

  /* Starting point, x = (5,7) */
  x = gsl_vector_alloc (2);
  gsl_vector_set (x, 0, 5.0);
  gsl_vector_set (x, 1, 7.0);

  /* Set initial step sizes to 1 */
  ss = gsl_vector_alloc (2);
  gsl_vector_set_all (ss, 1.0);

  /* Set up function to be minimized. */
  my_func.n = 2;  /* number of function components */
  my_func.f = &my_f;
  my_func.params = (void *) p;
  s = gsl_multimin_fminimizer_alloc(T, 2);
  gsl_multimin_fminimizer_set( s, &my_func, x, ss );

  /* Do optimization */
  for( ; iter < 100; iter++ )
    {
      status = gsl_multimin_fminimizer_iterate (s);
     
      if (status)
	break;

      size = gsl_multimin_fminimizer_size (s);
      status = gsl_multimin_test_size (size, 1e-2);
     
      if (status == GSL_SUCCESS)
	{
	  printf ("converged to minimum at\n");
	  printf ("%5d %.5f %.5f %10.5f %g\n", iter,
		  gsl_vector_get (s->x, 0), 
		  gsl_vector_get (s->x, 1), 
		  s->fval, size );
	  break;
	}

      printf ("%5d %.5f %.5f %10.5f %g\n", iter,
	      gsl_vector_get (s->x, 0), 
	      gsl_vector_get (s->x, 1), 
	      s->fval, size );
    }
}
