#include<stdio.h>
/*
void main(){
    printf("Hello World!\n");
}
*/

// int main(){
//     printf("����ģ�� ��������\n");
//     printf("����ģ�� ��������");
//     return 0;
// }

// int main(){
//     int a,b;
//     scanf("%d %d",&a,&b);
//     printf("%d",a+b);
//     return 0;
// }

// int main(){
//     int a,b;
//     scanf("%d %d", &a,&b);
//     printf("%.9f", (double)a/b );
//     return 0;
// }

int main(){
    int a,b;
    scanf("%d %d",&a,&b);
    printf("%d\n",(b/100)*100);
    printf("%d\n",((b%100)/10)*10);
    printf("%d\n",((b%100)%10));
    
    printf("%d\n", a*(b/100)*100);
    printf("%d\n",a*((b%100)/10)*10);
    printf("%d\n",a*((b%100)%10));



    printf("%d\n",a*b);
    return 0;
}