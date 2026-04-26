using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TP3_Partie1
{
    internal class Pays
    {
        /*
         * Code du continent :
         * 1 : Afrique
         * 2 : Amerique
         * 3 : Asie
         * 4 : Oceanie
         * 5 : Europe
         */

        public int codeContinent;
        public string nom;
        public string captitale;
        public int superficie; // en km2
        public int population;

        public Pays(int codeContinent, string nom, string captitale, int superficie, int population)
        {
            this.codeContinent = codeContinent;
            this.nom = nom;
            this.captitale = captitale;
            this.superficie = superficie;
            this.population = population;
        }

        public override string ToString()
        {
            return "Continent = " + codeContinent.ToString() + 
                ", mom = " + nom +
                ", capitale = " + captitale +
                ", superficie = " + superficie.ToString() +
                " km2, population = " + population.ToString();
        }
    }
}
