#include <stdio.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
    char buf[512];
    FILE *fp = NULL;
    printf(">> Please input : ");
    fflush(stdout);
    scanf("%s", buf);
    printf(">> %s \n", buf);
    fflush(stdout);
    getcwd(buf, 512);
    printf("Dir : %s \n", buf);
    fflush(stdout);
    fp = fopen("./flag", "r");
    if (fp != NULL)
    {
        fgets(buf, 512, fp);
        printf("Flag is -> %s\n", buf);
        fflush(stdout);
    }
    fclose(fp);
    return 0;
}