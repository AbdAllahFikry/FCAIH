#include <stdio.h>
#include <stdlib.h>
#define maxsize 20

void process(char array[maxsize]){
    int i;
    for(i=0;i<maxsize;i++){
    printf("%c\n",array[i]);
}
}

int deletee(int priority){
    if(priority == 1){
       int critical_size=0;
       return critical_size;
    }
    else if(priority == 2){
            int high_size=0;
            return high_size;
    }
    else if(priority == 3){
            int medium_size=0;
            return medium_size;
    }
    else{
        int low_size=0;
        return low_size;
    }
}


void empty (int *critical_size,int *high_size,int *medium_size, int *low_size){
     critical_size=0;
     high_size=0;
     medium_size=0;
     low_size=0;
}

int Partition(char array[],int left,int right){
    int pivot,i,j,z;
    pivot = array[left];
    i = left;
    j = right + 1;
    while(1){
        do i++;
        while(array[i] <= pivot && i <= right);
        do j--;
        while (array[j] > pivot);
        if (i >= j)
            break;
        z = array[i];
        array[i] = array[j];
        array[j] = z;
    }
    z = array[left];
    array[left] = array[j];
    array[j] = z;
    return j;
}

void QuickSort(char array[],int left,int right){
    int x;
    if(left < right){
        x = Partition(array,left,right);
        QuickSort(array,left,x - 1);
        QuickSort(array,x + 1,right);
    }
}

int BinarySearch(char array[],char target){
    int left=0;
    int right= maxsize - 1;
    //QuickSort(array,left, right);
    while(left <= right){
        int mid = left + (right - left) / 2;
        if(array[mid] == target)
            return mid;
        if(array[mid] < target)
            left = mid + 1;
        else
            right = mid - 1;
    }
    return -1;
}

int main()
{
    int critical_size=0,high_size=0,medium_size=0,low_size=0,no_of_requests,priority;
    int input,result;
    char target;
    char critical[maxsize];
    char request;
    printf("Enter 20 characters:\n");
    for(critical_size;critical_size<maxsize;critical_size++){
       scanf(" %c",&critical[critical_size]);
    }
    char high[maxsize];
    printf("Enter 20 characters:\n");
    for(high_size;high_size<maxsize;high_size++){
       scanf(" %c",&high[high_size]);
    }
    char medium[maxsize];
    printf("Enter 20 characters:\n");
    for(medium_size;medium_size<maxsize;medium_size++){
       scanf(" %c",&medium[medium_size]);
    }
    char low[maxsize];
    printf("Enter 20 characters:\n");
    for(low_size;low_size<maxsize;low_size++){
       scanf(" %c",&low[low_size]);
    }
    printf("\n choose from this menu:\n 1-binary search in critical requests\n 2-binary search in high requests\n 3-binary search in medium requests\n 4-binary search in low requests\n 5-delete all requests in critical\n 6-delete all requests in high\n 7-delete all requests in medium\n 8-delete all requests in low\n 9-process all requests in critical\n 10-process all requests in high\n 11-process all requests in medium\n 12-process all requests in low\n 13-empty all arrays\n 14-quick sort for critical\n 15-quick sort for high\n 16-quick sort for medium\n 17-quick sort for low\n 0-exit from the program\n");

   do{
        printf("enter another choice from the menu:");
        scanf("%d",&input);
   switch (input){
    case 1:
            {
         printf("\nEnter the element you want to search for: ");
         scanf(" %c",&target);
         int result = BinarySearch(critical, target);
         if(result == -1)
             printf("\nElement is not present in array\n");
         else
             printf("\nElement is present at index %d\n",result);
            }
    break;
    case 2:
             {
         printf("\nEnter the element you want to search for: ");
         scanf(" %c",&target);
         int result = BinarySearch(high, target);
         if(result == -1)
             printf("\nElement is not present in array\n");
         else
             printf("\nElement is present at index %d\n",result);
             }
    break;
    case 3:
        {
         printf("\nEnter the element you want to search for: ");
         scanf(" %c",&target);
         int result = BinarySearch(medium, target);
         if(result == -1)
             printf("\nElement is not present in array\n");
         else
             printf("\nElement is present at index %d\n",result);
        }
    break;
    case 4:
        {
          printf("\nEnter the element you want to search for: ");
         scanf(" %c",&target);
         int result = BinarySearch(low, target);
         if(result == -1)
             printf("\nElement is not present in array\n");
         else
             printf("\nElement is present at index %d\n",result);
        }
    break;
    case 5:
        {
         deletee(1);
         printf("critical array requests are deleted");
        }
    break;
    case 6:
        {
         deletee(2);
         printf("high array requests are deleted");
        }
    break;
    case 7:
        {
         deletee(3);
         printf("medium array requests are deleted");
        }
    break;
    case 8:
        {
         deletee(4);
         printf("low array requests are deleted");
        }
    break;
    case 9:
        {
         process(critical);
        }
    break;
    case 10:
        {
         process(high);
        }
    break;
    case 11:
        {
          process(medium);
        }
    break;
   case 12:
        {
         process(low);
        }
    break;
    case 13:
        {
          empty(critical_size,high_size,medium_size,low_size);
          printf("\nall arrays requests are deleted");
        }
    break;
    case 14:
        {
        QuickSort(critical,0,maxsize-1);
        process(critical);
        }
    break;
    case 15:
        {
         QuickSort(high,0,maxsize-1);
         process(high);
        }
    break;
    case 16:
        {
        QuickSort(medium,0,maxsize-1);
        process(medium);
        }
    break;
    case 17:
        {
        QuickSort(low,0,maxsize-1);
        process(low);
        }
    break;
   }
   }while(input!=0);



    return 0;
}
